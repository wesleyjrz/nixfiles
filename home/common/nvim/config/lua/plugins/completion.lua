return {
	"hrsh7th/nvim-cmp",
	version = "*",
	dependencies = {
		-- Autocompletion
		"hrsh7th/cmp-nvim-lsp",

		-- Path autocompletion
		"hrsh7th/cmp-path",

		-- Neovim Lua autocompletion
		"hrsh7th/cmp-nvim-lua",

		-- Buffer words autocompletion
		"hrsh7th/cmp-buffer",

		-- VSC-like pictograms
		"onsails/lspkind.nvim",

		{
			"L3MON4D3/LuaSnip",
			event = "VeryLazy",
			version = "*",
			dependencies = {
				-- Autocompletion integration
				"saadparwaiz1/cmp_luasnip",

				-- Snippets collection
				{ "rafamadriz/friendly-snippets", version = "6e0afe3" },
			},
			init = function()
				vim.keymap.set("n", "<Tab>", "<cmd>lua require('luasnip').jump(1)<CR>", {
					silent = true,
					desc = "Jump to the next snippet field",
				})

				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup {
			mapping = {
				["<C-space>"] = function()
					if cmp.visible() then
						cmp.close()
					else
						cmp.complete()
					end
				end,
				["<C-n>"] = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end,
				["<C-p>"] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end,
				["<C-j>"] = cmp.mapping.scroll_docs(3),
				["<C-k>"] = cmp.mapping.scroll_docs(-3),
				["<C-l>"] = function(fallback)
					if cmp.visible() then
						cmp.confirm {
							behavior = cmp.ConfirmBehavior.Replace,
							select = true,
						}
					else
						fallback()
					end
				end,
			},

			sources = {
				{ name = "path", keyword_length = 3 },
				{ name = "luasnip", keyword_length = 2 },
				{ name = "nvim_lsp", keyword_length = 2, group_index = 1 },
				{ name = "nvim_lua", keyword_length = 2 },
				{ name = "buffer", keyword_length = 4, group_index = 2 },
			},

			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			formatting = {
				format = require("lspkind").cmp_format {
					with_text = true,
					menu = {
						path = "[path]",
						luasnip = "[snip]",
						nvim_lsp = "[LSP]",
						nvim_lua = "[api]",
						buffer = "[buf]",
					},
				},
			},
		}
	end,
	init = function()
		-- Disable Neovim built-in completion
		vim.keymap.set("i", "<C-n>", "<Nop>", silent)
		vim.keymap.set("i", "<C-p>", "<Nop>", silent)
	end,
}
