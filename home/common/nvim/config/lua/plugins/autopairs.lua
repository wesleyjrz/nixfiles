return {
	"windwp/nvim-autopairs",
	event = "VeryLazy",
	opts = {
		check_ts = true, -- use tree-sitter
		disable_in_macro = true, -- disable it when recording a macro
		enable_check_bracket_line = true, -- don't add pairs if it has already a close pair in the same line
	},
}
