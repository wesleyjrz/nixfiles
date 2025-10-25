return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	version = "*",
	opts = {
		padding = true, -- add a space after the comment string
		toggler = { line = "gcc" },
		opleader = {
			line = "gc",
			block = "gb",
		},
		extra = {
			above = "gcO",
			below = "gco",
			eol = "gcA",
		},
		mappings = {
			-- Operator-pending mapping
			-- Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
			basic = true,
			-- Extra mapping
			-- Includes `gco`, `gcO`, `gcA`
			extra = true,
			-- Extended mapping
			-- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
			extended = false,
		},
	},
	init = function()
		local api = require("Comment.api")

		-- Extra block comment keys
		vim.keymap.set("n", "gbO", api.insert.blockwise.above, { silent = true })
		vim.keymap.set("n", "gbo", api.insert.blockwise.below, { silent = true })
	end,
}
