return {
	"xiyaowong/transparent.nvim",
	opts = {
		extra_groups = {
			"MsgArea",
			"WinSeparator",
			"VertSplit",
			"NormalFloat",
			"GitSignsAdd",
			"GitSignsDelete",
			"GitSignsChange",
			"WhichKeyBorder",
			"RenderMarkdownH1Bg",
			"RenderMarkdownH2Bg",
			"RenderMarkdownH3Bg",
			"RenderMarkdownH4Bg",
			"RenderMarkdownH5Bg",
			"RenderMarkdownH6Bg",
		},
	},
	init = function()
		vim.keymap.set("n", "<leader>ot", "<cmd>TransparentToggle<CR>", {
			desc = "Toggle transparency",
		})
	end,
}
