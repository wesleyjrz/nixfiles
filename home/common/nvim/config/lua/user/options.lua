local opt = vim.opt
local o = vim.o
local g = vim.g
local u = useropt

--[[ Appearance ]]

-- Colours
o.termguicolors = true

-- Command line and tabline
o.pumheight = 10 -- max number of items to show in the popup menu
o.showtabline = 1
o.laststatus = 3 -- global tabline

-- Line number
o.number = true -- show line numbers
o.relativenumber = true -- show relative line numbers
o.numberwidth = 2 -- number of columns to use for line number
o.signcolumn = "yes:1" -- sign column width

-- List mode (show whitespaces)
o.list = false
o.listchars = "trail:·,multispace:·,nbsp:␣,tab:  ,extends:<,precedes:>"

-- Line wrap
o.wrap = true
o.linebreak = true -- whether to break incomplete words

DiagnosticSigns = { -- Diagnostic signs
	Error = "",
	Warning = "",
	Warn = "",
	Hint = "󰌶",
	Info = "",
}

--[[ Language and encoding ]]

o.fileencoding = "utf-8" -- default file encoding
o.spelllang = "en,pt" -- spell checker languages

--[[ Silent ]]

o.hidden = true -- do not ask to write file when switching buffers
opt.shortmess:append("A") -- don't show warning for found swap files

--[[ Search ]]

o.ignorecase = true -- ignore case in search patterns
o.wildignorecase = true -- ignore case when completing file names and directories

--[[ Backup ]]

o.undofile = true
o.swapfile = true
o.updatecount = 200 -- after typing this many characters the swap file will be written
o.updatetime = 2000 -- if this many milliseconds nothing is typed, the swap file will be written

--[[ Formatting and Indentation ]]

o.shiftwidth = 0 -- number of spaces to use for each step of autoindent, 0 uses tabstop values
o.tabstop = 4 -- number of spaces that tabs in the file counts for
o.smarttab = false -- when on, a tab in front of a line inserts space
o.smartindent = true -- do smart auto indent when starting a new line
o.autoindent = true -- copy indent from current line when starting a new line

--[[ Scrolling ]]

o.scrolloff = 8 -- lines to keep above and below the cursor
o.sidescrolloff = 8 -- columns to keep to the left and right of the cursor

--[[ Windows ]]

o.splitright = true
o.splitbelow = true

--[[ netrw ]]

g.netrw_liststyle = 3 -- change default directory view
g.netrw_banner = 0 -- hide banner

--[[ Misc ]]

opt.clipboard:append("unnamedplus") -- system clipboard access (depends on xclip)
o.autochdir = true -- always change the current directory to the file parent directory
o.history = 1000 -- history max entries
o.mouse = "nv" -- mouse support
o.exrc = true -- local config files support
