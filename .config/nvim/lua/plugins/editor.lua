local util = require("util")

return {
	{
		url = "https://www.github.com/kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		url = "https://www.github.com/lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		opts = {
			debounce = 100,
			indent = {
				char = {
					" ",
					"░",
					"▒",
					"▓",
					"█",
					"▓",
					"▒",
					"░",
					" ",
					"░",
					"▒",
					"▓",
					"█",
					"▓",
					"▒",
					"░",
					" ",
				},
			},
			whitespace = { remove_blankline_trail = true },
			scope = {
				show_start = true,
				show_end = true,
				show_exact_scope = true,
				highlight = { "Function" },
			},
		},
	},
	{
		url = "https://www.github.com/hrsh7th/nvim-cmp",
		event = "VeryLazy",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP completion
			"hrsh7th/cmp-nvim-lsp-document-symbol", -- LSP completion
			"hrsh7th/cmp-nvim-lsp-signature-help", -- LSP completion
			"hrsh7th/cmp-buffer", -- Buffer completion
			"hrsh7th/cmp-path", -- Completion for paths
			"hrsh7th/cmp-cmdline", -- Completion for command line
			"hrsh7th/cmp-nvim-lua", -- Neovim Lua completion source
			"windwp/nvim-autopairs", -- Autopairs completion
			"dmitmel/cmp-digraphs", -- Vim digraph completion
			{
				url = "https://www.github.com/windwp/nvim-autopairs",
				event = "InsertEnter",
				opts = {
					disable_filetype = { "TelescopePrompt" },
					disable_in_macro = true,
					disable_in_visualblock = false,
					disable_in_replace_mode = true,
					ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
					enable_moveright = true,
					enable_afterquote = true,
					enable_check_bracket_line = true,
					enable_bracket_in_quote = true,
					enable_abbr = false,
					break_undo = true,
					check_ts = true,
					map_cr = true,
					map_bs = true,
					map_c_h = false,
					map_c_w = false,
				},
			},
		},
		opts = function()
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.enabled = function()
				-- disable completion in comments
				local context = require("cmp.config.context")
				-- keep command mode completion enabled when cursor is in a comment
				if vim.api.nvim_get_mode().mode == "c" then
					return true
				else
					return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
				end
			end

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})

			return {
				view = {
					entries = "custom",
				},
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
					},
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(_, vim_item)
						vim_item.menu = string.format("(%s)", vim_item.kind)
						return vim_item
					end,
				},
				snippet = {},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<Tab>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp", keyword_length = 3 },
					{ name = "nvim_lsp_document_symbol", keyword_length = 3 },
					{ name = "nvim_lsp_signature_help", keyword_length = 3 },
					{ name = "path", keyword_length = 3 },
					{ name = "cmdline", keyword_length = 3 },
					{ name = "nvim_lua", keyword_length = 3 },
					{ name = "autopairs", keyword_length = 3 },
					{ name = "digraphs", keyword_length = 2 },
				},
				enabled = function()
					local context = require("cmp.config.context")
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					else
						return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
					end
				end,
			}
		end,
	},
	{
		url = "https://www.github.com/folke/which-key.nvim",
		name = "which-key.nvim",
		event = "VimEnter",
		init = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 300
		end,
		opts = {
			preset = "modern",
			icons = {
				breadcrumb = "", -- symbol used in the command line area that shows your active key combo
				separator = "→", -- symbol used between a key and it's label
				group = "⇒", -- symbol prepended to a group,
				mappings = false,
			},
			win = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				no_overlap = true,
				border = "none", -- none, single, double, shadow
				padding = { 1, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
				title = true,
				title_pos = "center",
				zindex = 1000, -- positive value to position WhichKey above other floating windows.
			},
			layout = {
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 10, -- spacing between columns
				align = "center", -- align columns left, center or right
			},
		},
	},
	{
		url = "https://www.github.com/akinsho/toggleterm.nvim",
		version = "*",
		event = "VimEnter",
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return 84
				end
			end,
			open_mapping = nil,
			hide_numbers = true,
			autochdir = false,
			shade_terminals = false,
			start_in_insert = true,
			insert_mappings = false,
			terminal_mappings = true,
			persist_size = false,
			persist_mode = false,
			direction = "vertical",
			close_on_exit = true,
			shell = vim.o.shell,
			auto_scroll = true,
		},
		init = function()
			local toggleterm = require("toggleterm")
			local ns_id = vim.api.nvim_create_namespace("Terminal")
			local trim_spaces = true

			local set_opfunc = vim.fn[vim.api.nvim_exec(
				[[
      func s:set_opfunc(val)
        let &opfunc = a:val
      endfunc
      echon get(function('s:set_opfunc'), 'name')
    ]],
				true
			)]

			local ipy_cmd = function()
				if os.getenv("VIRTUAL_ENV") ~= nil then
					return os.getenv("VIRTUAL_ENV") .. "/bin/ipython"
				elseif os.getenv("WORKON_HOME") ~= nil then
					return os.getenv("WORKON_HOME") .. "/ipython/bin/ipython"
				else
					return "ipython"
				end
			end

			local Terminal = require("toggleterm.terminal").Terminal
			local ipython = Terminal:new({ cmd = ipy_cmd(), hidden = true })
			local bash = Terminal:new({ cmd = "bash", hidden = true })

			local repl_toggle = function()
				if vim.bo.filetype == "python" or ipython:is_open() then
					ipython:toggle()
				else
					bash:toggle()
				end
			end

			util.vmap("<leader><C-enter>", function()
				set_opfunc(function(motion_type)
					toggleterm.send_lines_to_terminal(motion_type, false, { args = vim.v.count })
				end)
				vim.api.nvim_feedkeys("g@", "v", false)
			end, vim.api.nvim_get_current_buf(), "Send Motion to Terminal")

			util.nmap("<leader><C-enter>", function()
				set_opfunc(function(motion_type)
					toggleterm.send_lines_to_terminal(motion_type, false, { args = vim.v.count })
				end)
				vim.api.nvim_feedkeys("g@", "n", false)
			end, vim.api.nvim_get_current_buf(), "Send Motion to Terminal")

			util.nmap("<leader><leader><C-enter>", function()
				set_opfunc(function(motion_type)
					toggleterm.send_lines_to_terminal(motion_type, false, { args = vim.v.count })
				end)
				vim.api.nvim_feedkeys("ggg@G''", "n", false)
			end, vim.api.nvim_get_current_buf(), "Send File to Terminal")

			util.nmap([[<C-enter>]], repl_toggle, vim.api.nvim_get_current_buf(), "Toggle REPL")

			util.nmap("<leader>sl", function()
				local current_buf = vim.api.nvim_get_current_buf()
				local cursor_pos = vim.fn.getpos(".")
				local start_line = cursor_pos[2] - 1
				local start_col = 0
				local end_line = cursor_pos[2]
				local end_col = -1

				vim.api.nvim_buf_add_highlight(current_buf, ns_id, "IncSearch", start_line, start_col, end_col)
				vim.defer_fn(function()
					vim.api.nvim_buf_clear_namespace(current_buf, ns_id, start_line - 1, end_line)
				end, 100)

				toggleterm.send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
			end, vim.api.nvim_get_current_buf(), "[S]end [L]ine to Terminal")

			util.vmap("<leader>sl", function()
				local current_buf = vim.api.nvim_get_current_buf()

				local start_pos = vim.fn.getpos("'<")
				local end_pos = vim.fn.getpos("'>")
				local start_line = start_pos[2] - 1
				local start_col = start_pos[3] - 1
				local end_line = end_pos[2]
				local end_col = -1

				vim.api.nvim_buf_add_highlight(current_buf, ns_id, "IncSearch", start_line, start_col, end_col)
				vim.defer_fn(function()
					vim.api.nvim_buf_clear_namespace(current_buf, ns_id, start_line - 1, end_line)
				end, 100)

				toggleterm.send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
			end, vim.api.nvim_get_current_buf(), "[S]end [L]ines to Terminal")

			util.vmap("<leader>ss", function()
				local current_buf = vim.api.nvim_get_current_buf()

				local start_pos = vim.fn.getpos("'<")
				local end_pos = vim.fn.getpos("'>")
				local start_line = start_pos[2] - 1
				local start_col = start_pos[3] - 1
				local end_line = end_pos[2]
				local end_col = end_pos[3]

				vim.api.nvim_buf_add_highlight(current_buf, ns_id, "IncSearch", start_line, start_col, end_col)
				vim.defer_fn(function()
					vim.api.nvim_buf_clear_namespace(current_buf, ns_id, start_line - 1, end_line)
				end, 100)

				toggleterm.send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })
			end, vim.api.nvim_get_current_buf(), "[S]end [S]election to Terminal")

			local term_enter_group = vim.api.nvim_create_augroup("TerminalEnter", { clear = true })
			vim.api.nvim_create_autocmd({ "TermOpen" }, {
				pattern = { "*" },
				group = term_enter_group,
				callback = function()
					if vim.opt.buftype:get() == "terminal" then
						util.tmap("<esc>", [[<C-\><C-n>]], vim.api.nvim_get_current_buf(), "")
						util.tmap("<C-w>h", [[<Cmd>wincmd h<CR>]], vim.api.nvim_get_current_buf(), "")
						util.tmap("<C-w>j", [[<Cmd>wincmd j<CR>]], vim.api.nvim_get_current_buf(), "")
						util.tmap("<C-w>k", [[<Cmd>wincmd k<CR>]], vim.api.nvim_get_current_buf(), "")
						util.tmap("<C-w>l", [[<Cmd>wincmd l<CR>]], vim.api.nvim_get_current_buf(), "")
						util.tmap("<C-w>w", [[<C-\><C-n><C-w>]], vim.api.nvim_get_current_buf(), "")
						util.tmap([[<C-enter>]], repl_toggle, vim.api.nvim_get_current_buf(), "Toggle REPL")
					end
				end,
			})

			-- TODO Reimplement this for toggleterm, doesn't seem to work properly
			-- vim.api.nvim_create_autocmd({ "WinResized", "WinLeave", "WinEnter" }, {
			--   pattern = { "*" },
			--   group = term_enter_group,
			--   callback = function()
			--       local bufnr = vim.api.nvim_get_current_buf()
			--       if vim.api.nvim_get_option_value("filetype", {buf = bufnr}) == 'terminal' then
			--         -- local target_width = math.floor(0.34 * vim.o.columns) -- or 84
			--         local target_width = 84
			--         local target_height = vim.o.lines
			--
			--         if vim.api.nvim_win_get_width(bufnr) ~= target_width then
			--           vim.api.nvim_win_set_width(bufnr, target_width)
			--         end
			--         if vim.api.nvim_win_get_height(bufnr) ~= target_height then
			--           vim.api.nvim_win_set_height(bufnr, target_height)
			--         end
			--       end
			--   end,
			-- })

			vim.api.nvim_create_autocmd("TermClose", {
				group = term_enter_group,
				callback = function()
					local bufnr = vim.api.nvim_get_current_buf()
					if vim.api.nvim_get_option_value("filetype", { buf = bufnr }) then
						vim.api.nvim_buf_delete(bufnr, { force = true, unload = false })
					end
				end,
			})
		end,
	},
	{
		url = "https://www.github.com/stevearc/oil.nvim",
		event = "VimEnter",
		opts = {
			default_file_explorer = true,
			columns = {
				-- "icon",
				"permissions",
				"size",
				"mtime",
			},
			buf_options = {
				buflisted = false,
				bufhidden = "hide",
			},
			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "nvic",
			},
			lsp_file_methods = {
				enabled = true,
				timeout_ms = 1000,
				autosave_changes = false,
			},
			constrain_cursor = "name",
			watch_for_changes = true,
			view_options = {
				show_hidden = true,
				is_hidden_file = function(name, _)
					local m = name:match("^%.")
					return m ~= nil
				end,
				is_always_hidden = function(_, _)
					return false
				end,
				natural_order = "fast",
				case_insensitive = false,
				sort = {
					{ "type", "asc" },
					{ "name", "asc" },
				},
			},
		},
	},
}
