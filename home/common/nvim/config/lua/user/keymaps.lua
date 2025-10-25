local map = vim.keymap.set

--[[ General keys ]]

-- Set ";" as the leader key
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- Hide searching highlights with cancel key
for _, key in pairs { "<Esc>", "<C-c>" } do
	map("n", key, "<cmd>nohlsearch<CR>", {
		silent = true,
		desc = "Hide searching highlights",
	})
end

-- Toggle spell checker
map("n", "<leader>os", "<cmd>set spell!<CR>", {
	desc = "Toggle spell",
})

-- Run Makefile in current workdir
if utils.file_exists("Makefile") then
	map("n", "<F5>", "<cmd>silent! make<CR>", {
		desc = "Run Makefile (silent)",
	})
	map("n", "<leader>m", "<cmd>make<CR>", {
		desc = "Run Makefile",
	})
end

--[[ Windows and buffers navigation ]]

-- Navigate between visual lines, unless when jumping a number of lines
--[[

map("n", "j", "v:count ? 'j' : 'gj'", {
	silent = true,
	expr = true,
})
map("n", "k", "v:count ? 'k' : 'gk'", {
	silent = true,
	expr = true,
})

]]

-- Easier window navigation
map("n", "<C-h>", "<cmd>wincmd h<CR>", {
	silent = true,
	desc = "Go to the left window",
})
map("n", "<C-j>", "<cmd>wincmd j<CR>", {
	silent = true,
	desc = "Go to the window below",
})
map("n", "<C-k>", "<cmd>wincmd k<CR>", {
	silent = true,
	desc = "Go to the window above",
})
map("n", "<C-l>", "<cmd>wincmd l<CR>", {
	silent = true,
	desc = "Go to the right window",
})

-- Move windows
map("n", "<C-w>h", "<cmd>wincmd H<CR>", {
	silent = true,
	desc = "Move window left",
})
map("n", "<C-w>j", "<cmd>wincmd J<CR>", {
	silent = true,
	desc = "Move window down",
})
map("n", "<C-w>k", "<cmd>wincmd K<CR>", {
	silent = true,
	desc = "Move window up",
})
map("n", "<C-w>l", "<cmd>wincmd L<CR>", {
	silent = true,
	desc = "Move window right",
})

-- Resize windows
map("n", "<C-up>", "<cmd>resize +2<CR>", {
	silent = true,
	desc = "Grow window vertically",
})
map("n", "<C-down>", "<cmd>resize -2<CR>", {
	silent = true,
	desc = "Shrink window vertically",
})
map("n", "<C-left>", "<cmd>vertical resize -2<CR>", {
	silent = true,
	desc = "Shrink window horizontally",
})
map("n", "<C-right>", "<cmd>vertical resize +2<CR>", {
	silent = true,
	desc = "Grow window horizontally",
})

-- Buffers navigation
map("n", "<C-n>", "<cmd>bnext<CR>", {
	silent = true,
	desc = "Go to the next buffer",
})
map("n", "<C-p>", "<cmd>bprevious<CR>", {
	silent = true,
	desc = "Go to the previous buffer",
})

-- Quickfix navigation
map("n", "<leader>qn", "<cmd>cnext<CR>", {
	silent = true,
	desc = "Go to the next item in the quickfix list",
})
map("n", "<leader>qp", "<cmd>cprevious<CR>", {
	silent = true,
	desc = "Go to the previous item in the quickfix list",
})
