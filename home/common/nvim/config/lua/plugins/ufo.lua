return {
	"kevinhwang91/nvim-ufo",
	version = "*",
	dependencies = "kevinhwang91/promise-async",
	config = function()
		local ufo = require("ufo")
		local o = vim.o
		local map = vim.keymap.set

		--[[ Keymaps ]]
		map("n", "zR", ufo.openAllFolds, {
			desc = "Open all folds",
		})
		map("n", "zM", ufo.closeAllFolds, {
			desc = "Close all folds",
		})
		map("n", "zr", ufo.openFoldsExceptKinds, {
			desc = "Close all folds except kinds",
		})
		map("n", "K", ufo.peekFoldedLinesUnderCursor, {
			desc = "Show folding preview",
		})

		--[[ Setup ]]
		o.foldcolumn = "0"
		o.foldlevel = 99 -- ufo provider needs a large value
		o.foldlevelstart = 99 -- default folding level
		o.foldenable = true

		local handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local suffix = (" ↵ "):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0

			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, { suffix, "MoreMsg" })
			return newVirtText
		end

		local ftMap = {
			git = "",
		}

		ufo.setup {
			open_fold_hl_timeout = 0,
			preview = {
				win_config = {
					winblend = 0,
					maxheight = 16,
				},
				mappings = {
					scrollF = "<C-j>",
					scrollB = "<C-k>",
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					close = "<C-c>",
				},
			},
			fold_virt_text_handler = handler,
			provider_selector = function(filetype)
				return ftMap[filetype] or { "treesitter", "indent" }
			end,
		}
	end,
}
