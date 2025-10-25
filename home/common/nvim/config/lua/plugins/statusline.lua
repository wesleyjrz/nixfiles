return {
	"rebelot/heirline.nvim",
	version = "*",
	config = function()
		local fn = vim.fn
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")
		local get_hl = require("heirline.utils").get_highlight

		local function setup_colors()
			return {
				statusline_bg = base16_colors.base01 or get_hl("StatusLine").bg,
				statusline_fg = base16_colors.base07 or get_hl("StatusLine").fg,
				statusline_dark_bg = base16_colors.base00 or get_hl("TabLineSel").bg,
				red = base16_colors.base08,
				dark_red = base16_colors.base08,
				green = base16_colors.base0B,
				blue = base16_colors.base0D,
				gray = base16_colors.base03,
				orange = base16_colors.base09,
				purple = base16_colors.base0E,
				cyan = base16_colors.base0C,
				diag_warn = base16_colors.base0A or get_hl("DiagnosticWarn").fg or get_hl(
					"WarningText"
				).fg or get_hl("WarningMsg").fg,
				diag_error = base16_colors.base08 or get_hl("DiagnosticError").fg or get_hl(
					"ErrorText"
				).fg or get_hl("ErrorMsg").fg,
				diag_hint = base16_colors.base0D or get_hl("DiagnosticHint").fg or get_hl(
					"HintText"
				).fg or get_hl("MoreMsg").fg,
				diag_info = base16_colors.base0B or get_hl("DiagnosticInfo").fg or get_hl(
					"InfoText"
				).fg or get_hl("ModeMsg").fg,
				git_del = base16_colors.base08,
				git_add = base16_colors.base0B,
				git_change = base16_colors.base0A,
			}
		end

		vim.api.nvim_create_augroup("Heirline", { clear = true })
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				utils.on_colorscheme(setup_colors)
			end,
			group = "Heirline",
		})

		--[[ Vi Mode ]]
		-- Show current mode.
		local vi_mode = {
			init = function(self)
				self.mode = fn.mode(1) -- :h mode()
			end,
			static = {
				mode_names = {
					n = "N",
					no = "N?",
					nov = "N?",
					noV = "N?",
					["no\22"] = "N?",
					niI = "Ni",
					niR = "Nr",
					niV = "Nv",
					nt = "Nt",
					v = "V",
					vs = "Vs",
					V = "V_",
					Vs = "Vs",
					["\22"] = "^V",
					["\22s"] = "^V",
					s = "S",
					S = "S_",
					["\19"] = "^S",
					i = "I",
					ic = "Ic",
					ix = "Ix",
					R = "R",
					Rc = "Rc",
					Rx = "Rx",
					Rv = "Rv",
					Rvc = "Rv",
					Rvx = "Rv",
					c = "C",
					cv = "Ex",
					r = "...",
					rm = "M",
					["r?"] = "?",
					["!"] = "!",
					t = "T",
				},
				mode_colors = {
					n = "red",
					i = "green",
					v = "cyan",
					V = "cyan",
					["\22"] = "cyan",
					c = "orange",
					s = "purple",
					S = "purple",
					["\19"] = "purple",
					R = "orange",
					r = "orange",
					["!"] = "red",
					t = "red",
				},
			},
			provider = function(self)
				return " %2(" .. self.mode_names[self.mode] .. "%)"
			end,
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
			hl = function(self)
				local mode = self.mode:sub(1, 1)
				return { bg = "statusline_dark_bg", fg = self.mode_colors[mode], bold = true }
			end,
		}

		vi_mode = utils.surround({ "█", "█" }, "statusline_dark_bg", { vi_mode })

		--[[ Git ]]
		-- Show git diff indicators.
		local git = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = (self.status_dict.added and self.status_dict.added ~= 0)
					or (self.status_dict.removed and self.status_dict.removed ~= 0)
					or (self.status_dict.changed and self.status_dict.changed ~= 0)
			end,
			{
				provider = "█",
				hl = { fg = "statusline_bg" },
			},
			{
				condition = function(self)
					return self.status_dict.head
				end,
				provider = function(self)
					return "  " .. ((self.status_dict.head ~= "" and nil) or "detached/unstaged")
				end,
				hl = { bold = true },
			},
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and ("  " .. count)
				end,
				hl = { fg = "git_add" },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and ("  " .. count)
				end,
				hl = { fg = "git_del" },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and ("  " .. count)
				end,
				hl = { fg = "git_change" },
			},
			{
				provider = "█",
				hl = { fg = "statusline_bg" },
			},

			hl = { bg = "statusline_bg" },
		}

		-- [[ Diagnostics (LSP) ]]
		-- Show LSP diagnostic indicators.
		local diagnostics = {
			condition = conditions.has_diagnostics,
			static = {
				error_icon = DiagnosticSigns.Error,
				warn_icon = DiagnosticSigns.Warn,
				hint_icon = DiagnosticSigns.Hint,
				info_icon = DiagnosticSigns.Info,
			},
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,
			update = { "DiagnosticChanged", "BufEnter" },
			{
				provider = function(self)
					return self.errors > 0 and (" " .. self.error_icon .. " " .. self.errors)
				end,
				hl = { fg = "diag_error" },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (" " .. self.warn_icon .. " " .. self.warnings)
				end,
				hl = { fg = "diag_warn" },
			},
			{
				provider = function(self)
					return self.info > 0 and (" " .. self.info_icon .. " " .. self.info)
				end,
				hl = { fg = "diag_info" },
			},
			{
				provider = function(self)
					return self.hints > 0 and (" " .. self.hint_icon .. " " .. self.hints)
				end,
				hl = { fg = "diag_hint" },
			},
			{
				provider = "█",
				hl = { fg = "statusline_bg" },
			},
			hl = { bg = "statusline_bg" },
		}

		--[[ Filename Block ]]
		-- General file information: name, status, etc.
		local filename_block = {
			init = function(self)
				self.file = vim.api.nvim_buf_get_name(0)
			end,
			hl = { bg = "statusline_bg" },
		}

		local filename = {
			provider = function(self)
				local file = fn.fnamemodify(self.file, ":.")
				if file == "" then
					return " [No Name]"
				end
				if not conditions.width_percent_below(#file, 0.25) then
					file = fn.pathshorten(file)
				end
				return file
			end,
		}

		filename = utils.surround({ "█", "█" }, filename_block.hl.bg, { filename })

		local file_flags = {
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = " 󰏫 ",
				hl = {
					bg = "statusline_bg",
					fg = "green",
				},
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = " 󰏯 ",
				hl = {
					bg = "statusline_bg",
					fg = "red",
				},
			},
		}

		filename_block = utils.insert(filename_block, filename, file_flags, { provider = "%<" })

		--[[ Spell ]]
		-- Indicates when spell mode is enabled.
		local spell = {
			condition = function()
				return vim.wo.spell
			end,
			provider = "󰓆 ",
			hl = {
				fg = "green",
				bg = "statusline_bg",
				bold = true,
			},
		}

		spell = utils.surround({ "█", "█" }, "statusline_bg", { spell })

		--[[ File Encoding ]]
		local file_encoding = {
			provider = function()
				local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
				return enc ~= "utf-8" and enc:upper() .. " "
			end,
		}

		--[[ File Format ]]
		local file_format = {
			provider = function()
				local fmt = vim.bo.fileformat
				if fmt == "dos" then
					return "  "
				elseif fmt == "unix" then
					return "  "
				elseif fmt == "dos" then
					return "  "
				end
			end,
			hl = {
				bg = "statusline_bg",
				fg = "statusline_fg",
			},
		}

		file_format = utils.surround({ "█", "█" }, file_format.hl.bg, { file_format })

		--[[ File Type ]]
		-- Shows the type of the file: Text, C, Python, etc.
		local file_type_block = {
			provider = function()
				local filetype = vim.bo.filetype
				if filetype ~= "" then
					return filetype
				else
					return "∅ buffer"
				end
			end,
			hl = {
				fg = "green",
				bold = true,
			},
		}

		local file_icon = {
			init = function(self)
				local extension = fn.fnamemodify(file, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(file, extension, { default = true })
			end,
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		}

		file_type_block = utils.insert(file_icon, file_type_block)

		file_type_block = utils.surround(
			{ "█", "█" },
			"statusline_dark_bg",
			{ file_type_block }
		)

		--[[ Ruler ]]
		local ruler_percentage = {
			-- %P = percentage through file of displayed window
			provider = "%P",
			hl = {
				bg = "statusline_bg",
				fg = "statusline_fg",
			},
		}

		ruler_percentage = utils.surround(
			{ "█", "█" },
			ruler_percentage.hl.bg,
			{ ruler_percentage }
		)

		local ruler_position = {
			-- %l = current line number
			-- %c = column number
			provider = "%l:%2c",
			hl = {
				bg = "statusline_dark_bg",
				fg = "green",
			},
		}

		ruler_position = utils.surround({ "█", "█" }, ruler_position.hl.bg, { ruler_position })

		local ruler = utils.insert(ruler_percentage, ruler_position)

		local align = {
			provider = "%=",
			hl = { bg = "statusline_bg" },
		}

		local default_statusline = {
			vi_mode,
			git,
			diagnostics,
			filename_block,
			align,
			-- Empty middle
			spell,
			file_encoding,
			file_format,
			file_type_block,
			ruler,
		}

		require("heirline").setup {
			statusline = default_statusline,
			opts = { colors = setup_colors },
		}

		vim.cmd(
			[[ au FileType * if index(["wipe", "delete"], &bufhidden) >= 0 | set nobuflisted | endif ]]
		)
	end,
}
