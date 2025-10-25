return {
	"stevearc/oil.nvim",
	event = "VeryLazy",
	opts = {
		default_file_explorer = true,
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
	},
	init = function()
		vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
	end,
}
