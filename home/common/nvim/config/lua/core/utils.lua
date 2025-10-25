_G.useropt = {}
_G.utils = {}
local fn = vim.fn

--- Check if a file exists in the current working directory
-- @param filename string: Name of the file to check
-- @return boolean: Return true if the file with the given filename exists
function utils.file_exists(filename)
	local f = io.open(filename, "r")
	return f ~= nil and io.close(f)
end

--- Require all modules inside a directory
-- @param dirname string: Directory pathname to require
-- @return nil
function utils.requiredir(dirname)
	for _, file in
		ipairs(fn.readdir(fn.stdpath("config") .. "/lua/" .. dirname, [[v:val =~ "\.lua$"]]))
	do
		require(dirname .. "." .. file:gsub("%.lua$", ""))
	end
end

--- Check if a plugin is loaded by Lazy
-- @param plugin_name string: The plugin name to verify
-- @return boolean: Return true if the plugin is available (loaded)
function utils.is_available(plugin_name)
	return vim.tbl_get(require("lazy.core.config"), "plugins", plugin_name, "_", "loaded")
end

--- Check if current directory is inside a git repository
-- @param nil
-- @return boolean: Return true if the directory is a git repository
function utils.is_git_repo()
	local file = fn.expand("%:p")
	local dir = fn.fnamemodify(file, ":h")
	local output = fn.systemlist("git -C " .. dir .. " rev-parse --is-inside-work-tree")
	return vim.v.shell_error == 0 and output[1] == "true"
end
