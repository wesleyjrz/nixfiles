return {
	"RRethy/base16-nvim",
	priority = 1000,
	config = function()
		require("base16-colorscheme").setup {
			base00 = base16_colors.base00,
			base01 = base16_colors.base01,
			base02 = base16_colors.base02,
			base03 = base16_colors.base03,
			base04 = base16_colors.base04,
			base05 = base16_colors.base05,
			base06 = base16_colors.base06,
			base07 = base16_colors.base07,
			base08 = base16_colors.base08,
			base09 = base16_colors.base09,
			base0A = base16_colors.base0A,
			base0B = base16_colors.base0B,
			base0C = base16_colors.base0C,
			base0D = base16_colors.base0D,
			base0E = base16_colors.base0E,
			base0F = base16_colors.base0F,
		}
	end,
}
