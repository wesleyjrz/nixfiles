local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup

--[[ Augroups ]]

-- Set options
local options_aug = aug("Options", { clear = false })

-- Manage sessions
local session_aug = aug("Automation_Session", { clear = false })

-- Automate file formatting
local formatting_aug = aug("Automation_Formatting", { clear = false })

--[[ Restore view automatically ]]

au("BufWinLeave", {
	command = [[ silent! mkview ]],
	group = session_aug,
})
au("BufWinEnter", {
	command = [[ silent! loadview ]],
	group = session_aug,
})

--[[ Remove all trailing whitespaces and trim blank lines at the end of file ]]

au("BufWritePre", {
	command = [[ %s/\s\+$//e | %s/\($\n\s*\)\+\%$//e ]],
	group = formatting_aug,
})

--[[ Terminal options ]]
au("TermOpen", {
	command = [[
		setlocal nonumber
		setlocal norelativenumber
		setlocal nocursorline
	]],
	group = options_aug,
})
