return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	version = "*",
	dependencies = {
		{ "nvim-lua/plenary.nvim", version = "*" },
		"nvim-telescope/telescope-fzy-native.nvim",
		"LinArcX/telescope-command-palette.nvim",
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		local map = vim.keymap.set
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		--[[ Keymaps ]]
		-- Append groups to the key menu
		if utils.is_available("which-key.nvim") then
			local wk = require("which-key")
			wk.add { { "<leader>s", group = "search" } }
		end

		-- Show recent files
		map("n", "<leader>sr", builtin.oldfiles, {
			silent = true,
			desc = "Recent files",
		})

		-- View open buffers
		map("n", "<leader>b", builtin.buffers, {
			silent = true,
			nowait = true,
			desc = "List buffers",
		})

		-- Find files
		map("n", "<leader>sf", builtin.find_files, {
			silent = true,
			desc = "Search files",
		})

		-- Live grep
		map("n", "<leader>sg", builtin.live_grep, {
			silent = true,
			nowait = true,
			desc = "Live grep files",
		})

		-- Search history
		map("n", "<leader>sH", builtin.search_history, {
			silent = true,
			desc = "Show search history",
		})

		-- Command history
		map("n", "<leader>sC", builtin.command_history, {
			silent = true,
			desc = "Show command history",
		})

		-- Marks
		map("n", "<leader>sm", builtin.marks, {
			silent = true,
			desc = "Search vim marks",
		})

		-- Quickfix list
		map("n", "<leader>ql", builtin.quickfix, {
			silent = true,
			desc = "Quickfix list",
		})

		-- Quickfix history
		map("n", "<leader>sq", builtin.quickfixhistory, {
			silent = true,
			desc = "Quickfix history",
		})

		-- Find commands
		map("n", "<leader>sc", builtin.commands, {
			silent = true,
			desc = "Search commands",
		})

		-- Find keymaps
		map("n", "<leader>sk", builtin.keymaps, {
			silent = true,
			desc = "Search keymaps",
		})

		-- Find help
		map("n", "<leader>sh", builtin.help_tags, {
			silent = true,
			desc = "Search help",
		})

		-- Change colorscheme
		map("n", "<leader>oc", builtin.colorscheme, {
			silent = true,
			desc = "Change colorscheme",
		})

		-- Spell suggestions
		map("n", "z=", builtin.spell_suggest, { silent = true })

		-- Telescope undo history
		map("n", "<leader>u", "<cmd>Telescope undo<CR>", {
			silent = true,
			desc = "Undo history",
		})

		-- Git pickers
		if utils.is_git_repo() then
			-- Find files through `git ls-files`
			map("n", "<leader>gf", builtin.git_files, {
				silent = true,
				desc = "Search git tracked files",
			})

			map("n", "<leader>gc", builtin.git_commits, {
				silent = true,
				desc = "Show commits",
			})

			map("n", "<leader>gC", builtin.git_bcommits, {
				silent = true,
				desc = "Show buffer commits",
			})

			map("n", "<leader>gB", builtin.git_branches, {
				silent = true,
				desc = "List branches",
			})

			map("n", "<leader>gs", builtin.git_status, {
				silent = true,
				desc = "List changes",
			})

			map("n", "<leader>gS", builtin.git_stash, {
				silent = true,
				desc = "Show stash",
			})
		end

		-- List pickers
		map("n", "<leader>sp", builtin.builtin, {
			silent = true,
			desc = "Telescope builtin pickers",
		})

		--[[ Setup ]]
		telescope.setup {
			defaults = {
				prompt_prefix = "󰍉  ",
				selection_caret = "→",
				dynamic_preview_title = true,
				mappings = {
					i = {
						["<C-u>"] = false, -- use it to clear the prompt instead
						["<CR>"] = actions.select_default,
						["<C-l>"] = actions.select_default,
						["<C-q>"] = actions.close,
						["<C-n>"] = actions.move_selection_next,
						["<C-p>"] = actions.move_selection_previous,
						["<C-j>"] = actions.preview_scrolling_down,
						["<C-k>"] = actions.preview_scrolling_up,
						["<C-f>"] = actions.send_to_qflist,
						["<C-g>"] = actions.add_to_qflist,
					},
					n = {
						["<CR>"] = actions.select_default,
						["<C-l>"] = actions.select_default,
						["s"] = actions.file_split,
						["v"] = actions.file_vsplit,
						["dd"] = actions.delete_buffer,
						["D"] = actions.delete_buffer,
						["<space>"] = actions.toggle_selection,
						["<C-space>"] = actions.toggle_all,
						["u<space>"] = actions.drop_all,
						["<C-q>"] = actions.close,
						["<C-c>"] = actions.close,
						["<C-n>"] = actions.move_selection_next,
						["<C-p>"] = actions.move_selection_previous,
						["<C-d>"] = actions.results_scrolling_down,
						["<C-u>"] = actions.results_scrolling_up,
						["<C-j>"] = actions.preview_scrolling_down,
						["<C-k>"] = actions.preview_scrolling_up,
						["<C-f>"] = actions.send_selected_to_qflist,
						["<C-g>"] = actions.add_selected_to_qflist,
					},
				},
			},
			pickers = {
				oldfiles = { theme = "ivy" },
				buffers = { theme = "ivy" },
				current_buffer_fuzzy_find = { previewer = false },
				find_files = { theme = "ivy" },
				live_grep = { theme = "ivy" },
				search_history = { previewer = false },
				command_history = { previewer = false },
				marks = { theme = "ivy" },
				commands = { previewer = false },
				keymaps = { previewer = false },
				help_tags = { theme = "ivy" },
				diagnostics = { theme = "ivy" },
				lsp_document_symbols = { theme = "ivy" },
				lsp_dynamic_workspace_symbols = { theme = "ivy" },
				colorscheme = { previewer = false },
				spell_suggest = { previewer = false },
				git_files = { theme = "ivy" },
				git_commits = { previewer = false },
				git_bcommits = { previewer = false },
				git_branches = { previewer = false },
				git_status = { theme = "ivy" },
				git_stash = { previewer = false },
				builtin = { previewer = false },
			},
			extensions = {
				fzy_native = {
					override_generic_sorter = true,
					override_file_sorter = true,
				},
			},
		}

		local load_extensions = { "fzy_native" }

		for _, ext in ipairs(load_extensions) do
			pcall(telescope.load_extension(ext))
		end
	end,
}
