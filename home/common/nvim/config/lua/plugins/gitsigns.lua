return {
	"lewis6991/gitsigns.nvim",
	version = "*",
	cond = function()
		return utils.is_git_repo()
	end,
	opts = {
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			delay = 1000,
			ignore_whitespace = false,
		},
	},
	init = function()
		local map = vim.keymap.set

		if utils.is_available("which-key.nvim") then
			local wk = require("which-key")
			wk.add {
				{ "<leader>go", group = "git options" },
				{ "<leader>gh", group = "hunk" },
			}
		end

		map("n", "<leader>gos", "<cmd>Gitsigns toggle_signs<CR>", {
			silent = true,
			desc = "Toggle git sign column",
		})
		map("n", "<leader>god", "<cmd>Gitsigns toggle_word_diff<CR>", {
			silent = true,
			desc = "Toggle git word diff",
		})
		map("n", "<leader>gob", "<cmd>Gitsigns toggle_current_line_blame<CR>", {
			silent = true,
			desc = "Toggle inline git blame",
		})
		map("n", "<leader>ghs", "<cmd>Gitsigns stage_hunk<CR>", {
			silent = true,
			desc = "Stage hunk",
		})
		map("n", "<leader>ghr", "<cmd>Gitsigns reset_hunk<CR>", {
			silent = true,
			desc = "Reset hunk",
		})
		map("n", "<leader>ghS", "<cmd>Gitsigns stage_buffer<CR>", {
			silent = true,
			desc = "Stage buffer",
		})
		map("n", "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<CR>", {
			silent = true,
			desc = "Undo stage hunk",
		})
		map("n", "<leader>ghR", "<cmd>Gitsigns reset_buffer<CR>", {
			silent = true,
			desc = "Reset buffer",
		})
		map("n", "<leader>ghp", "<cmd>Gitsigns preview_hunk<CR>", {
			silent = true,
			desc = "Preview hunk",
		})
		map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", {
			silent = true,
			desc = "Blame line",
		})
	end,
}
