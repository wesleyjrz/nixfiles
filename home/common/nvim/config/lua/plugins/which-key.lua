return {
	"folke/which-key.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		preset = "helix",
		plugins = {
			marks = true,
			registers = true,
			spelling = { enabled = false },
		},
	},
	init = function()
		local wk = require("which-key")
		wk.add {
			{ "<leader>n", group = "notifications" },
			{ "<leader>o", group = "options" },
			{ "<leader>g", group = "git" },
			{ "<leader>q", group = "quickfix" },
			{ "<leader>w", proxy = "<C-w>", group = "windows" },
		}
	end,
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show { global = false }
			end,
			desc = "Show buffer local keymaps",
		},
	},
}
