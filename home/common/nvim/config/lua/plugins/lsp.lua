return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	version = "*",
	dependencies = {
		{ -- Neovim Lua API setup
			"folke/neodev.nvim",
			version = "*",
		},

		{ -- Lazy LuaLS setup for Neovim
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},

		{ -- Auto signature help
			"ray-x/lsp_signature.nvim",
			version = "*",
		},
	},
	config = function()
		local lsp = vim.lsp
		local diag = vim.diagnostic
		local lsp_aug = vim.api.nvim_create_augroup("Automation_LSP", { clear = false })

		local on_attach = function(_, bufnr)
			local nmap = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			-- Hover documentation
			-- NOTE: see `:help K` for why this keymap.
			if utils.is_available("nvim-ufo") then
				nmap("K", function()
					local winid = require("ufo").peekFoldedLinesUnderCursor()
					if not winid then
						lsp.buf.hover()
					end
				end, "Show folding preview / Show hover documentation")
			else
				nmap("K", lsp.buf.hover, "Show hover documentation")
			end

			-- Signature documentation
			nmap("<leader>k", lsp.buf.signature_help, "Signature help")

			-- Code action
			nmap("<leader>la", lsp.buf.code_action, "Code action")

			-- Go to definition
			nmap("<leader>lgd", lsp.buf.definition, "Goto definition")

			-- List references
			nmap("<leader>lgr", "<cmd>Telescope lsp_references<CR>", "Goto references")

			-- Go to implementation
			nmap("<leader>lgi", lsp.buf.implementation, "Goto implementation")

			-- Go to type definitions
			nmap("<leader>lgt", lsp.buf.type_definition, "Goto type definitions")

			-- Go to declaration
			nmap("<leader>lgD", lsp.buf.declaration, "Goto declaration")

			-- List symbols
			nmap("<leader>lsd", "<cmd>Telescope lsp_document_symbols<CR>", "Document symbols")
			nmap(
				"<leader>lsw",
				"<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
				"Workspace symbols"
			)

			-- Open diagnostics
			nmap("<leader>ld", "<cmd>Telescope diagnostics<CR>", "Diagnostics")

			-- Format with LSP
			nmap("<leader>fl", lsp.buf.format, "Format with LSP")

			-- Navigate between diagnostics
			nmap("]d", diag.goto_next, "Next diagnostic")
			nmap("[d", diag.goto_prev, "Previous diagnostic")

			-- Append groups to the key menu
			if utils.is_available("which-key.nvim") then
				local wk = require("which-key")
				wk.add {
					{ "<leader>l", group = "lsp" },
					{ "<leader>f", group = "format" },
					{ "<leader>ls", group = "symbols" },
					{ "<leader>lg", group = "goto" },
				}
			end

			-- Setup signature help plugin
			if utils.is_available("lsp_signature.nvim") then
				vim.keymap.set("i", "<C-k>", require("lsp_signature").toggle_float_win)
				require("lsp_signature").on_attach({
					floating_window = true,
					max_height = 16,
					doc_lines = 0,
					hint_enable = false,
					hint_prefix = "▲ ",
				}, bufnr)
			end
		end

		-- Disable inline diagnostics
		diag.config { virtual_text = false }

		-- Open diagnostic floating window with cursor hover
		vim.o.updatetime = 250
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
					if vim.api.nvim_win_get_config(winid).zindex then
						return
					end
				end
				diag.open_float(nil, { focusable = false })
			end,
			group = lsp_aug,
		})

		for type, icon in pairs(DiagnosticSigns) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon .. " ", texthl = hl, numhl = hl })
		end
	end,
}
