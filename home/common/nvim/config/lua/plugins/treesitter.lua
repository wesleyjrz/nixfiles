return {
	"nvim-treesitter/nvim-treesitter",
	version = "*",
	build = function()
		pcall(require("nvim-treesitter.install").update { with_sync = true })
	end,
	opts = {
		auto_install = true,
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"comment",
			"markdown",
			"markdown_inline",
			"regex",
			"json",
			"yaml",
			"toml",
		},
		highlight = {
			enable = true,
			use_languagetree = true,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
	},
}
