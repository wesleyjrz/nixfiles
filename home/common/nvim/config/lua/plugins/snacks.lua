return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		git = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		dim = { animate = { enabled = false } },
	},
	keys = {
		{
			"<leader>oz",
			function()
				Snacks.zen()
			end,
			desc = "Toggle zen mode",
		},
		{
			"<C-w>m",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle zoom",
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle scratch buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select scratch buffer",
		},
		{
			"<leader>nh",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification history",
		},
		{
			"<leader>nc",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Clear notifications",
		},
		{
			"<leader>od",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete buffer",
		},
		{
			"<leader>or",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename file",
		},
		{
			"<leader>gF",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit current file history",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit log (cwd)",
		},
		{
			-- FIXME
			"<C-\\>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle terminal",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>N",
			desc = "Neovim News",
			function()
				Snacks.win {
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.6,
					height = 0.6,
					wo = {
						spell = false,
						wrap = false,
						signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				}
			end,
		},
	},
}
