return {
	{
		url = "https://www.github.com/lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_syntax_enabled = false
			vim.g.vimtex_view_enabled = false
		end,
	},
	{
		{
			url = "https://www.github.com/folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				runtime = vim.env.VIMRUNTIME,
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
				integrations = {
					lspconfig = true,
					cmp = true,
					coq = false,
				},
			},
		},
	},
	{
		url = "https://www.github.com/kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = true,
	},
	{
		dir = "/home/air/projects/zathura.nvim",
		ft = "tex",
		opts = {
			girara = {
				["statusbar-basename"] = "true",
				["statusbar-home-tilde"] = "true",
				["statusbar-page-percent"] = "false",
				["window-title-basename"] = "true",
				["window-title-home-tilde"] = "true",
				["window-title-page"] = "false",
			},
			zathura = {
				["dbus-raise-window"] = "false",
				["recolor"] = "true",
				["recolor-keephue"] = "false",
				["nohlsearch"] = "false",
				["incremental-search"] = "true",
			},
		},
	},
	{
		-- url = "https://www.github.com/arizzoni/wal.nvim",
		dir = "/home/air/projects/wal.nvim",
		lazy = false,
		init = function()
			vim.g.wal_path = "/home/air/.cache/wallust/colors.json"
			vim.cmd("colo wal")
		end,
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
			"neovim/nvim-lspconfig", -- LSP configuration
			"hrsh7th/cmp-nvim-lsp", -- LSP completion
			"hrsh7th/cmp-nvim-lsp-document-symbol", -- LSP completion
			"hrsh7th/cmp-nvim-lsp-signature-help", -- LSP completion
			"hrsh7th/cmp-buffer", -- Buffer completion
			"hrsh7th/cmp-path", -- Completion for paths
			"hrsh7th/cmp-cmdline", -- Completion for command line
			"hrsh7th/cmp-emoji", -- Completion for emojis
			"hrsh7th/cmp-omni", -- Completion for Vim omnifunc
			"hrsh7th/cmp-calc", -- Calculator completions
			"hrsh7th/cmp-nvim-lua", -- Neovim Lua completion sources
			"rcarriga/cmp-dap", -- DAP completion sources
			"L3MON4D3/LuaSnip", -- LuaSnip snippet engine
			"saadparwaiz1/cmp_luasnip", -- LuaSnip snippet sources
			"folke/lazydev.nvim", -- Neovim lua completion sources
			"jmbuhr/otter.nvim", -- Injected language completions
			"micangl/cmp-vimtex", -- Completion for VimTeX
			{
				url = "https://www.github.com/windwp/nvim-autopairs",
				event = "InsertEnter",
				opts = {
					disable_filetype = { "" },
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
				local dap = require("cmp_dap")
				if vim.api.nvim_get_mode().mode == "c" then
					-- keep command mode completion enabled when cursor is in a comment
					return true
				elseif context.in_treesitter_capture("comment") and context.in_syntax_group("Comment") then
					-- disable completion in comments
					return false
				elseif vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" or dap.is_dap_buffer() then
					-- enable completion in prompts and dap buffers
					return true
				end
			end

			cmp.setup.cmdline({ "/", "?" }, {
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

			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "buffer" },
				}),
			})

			cmp.setup.filetype("tex", {
				sources = cmp.config.sources({
					{ name = "nvim_lsp", keyword_length = 3 },
					{ name = "nvim_lsp_document_symbol", keyword_length = 3 },
					{ name = "nvim_lsp_signature_help", keyword_length = 3 },
					{ name = "buffer", keyword_length = 3 },
					{ name = "path", keyword_length = 3 },
					{ name = "cmdline", keyword_length = 3 },
					{ name = "emoji", keyword_length = 3 },
					{ name = "omni", keyword_length = 3 },
					{ name = "calc", keyword_length = 3 },
					{ name = "autopairs", keyword_length = 3 },
					{ name = "luasnip", keyword_length = 3 },
					{ name = "otter", keyword_length = 3 },
					{ name = "vimtex", keyword_length = 3 },
				}),
			})

			cmp.setup.filetype("lua", {
				sources = cmp.config.sources({
					{ name = "nvim_lsp", keyword_length = 3 },
					{ name = "nvim_lsp_document_symbol", keyword_length = 3 },
					{ name = "nvim_lsp_signature_help", keyword_length = 3 },
					{ name = "buffer", keyword_length = 3 },
					{ name = "path", keyword_length = 3 },
					{ name = "cmdline", keyword_length = 3 },
					{ name = "emoji", keyword_length = 3 },
					{ name = "omni", keyword_length = 3 },
					{ name = "calc", keyword_length = 3 },
					{ name = "nvim_lua", keyword_length = 3 },
					{ name = "autopairs", keyword_length = 3 },
					{ name = "luasnip", keyword_length = 3 },
					{ name = "lazydev", keyword_length = 3 },
				}),
			})

			cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
				sources = {
					{ name = "dap" },
				},
			})

			return {
				view = {
					entries = "custom",
				},
				window = {
					completion = {
						-- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
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
				snippet = {
					exand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<Shift-Tab>"] = cmp.mapping.confirm({
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
					{ name = "buffer", keyword_length = 3 },
					{ name = "path", keyword_length = 3 },
					{ name = "emoji", keyword_length = 3 },
					{ name = "omni", keyword_length = 3 },
					{ name = "calc", keyword_length = 3 },
					{ name = "autopairs", keyword_length = 3 },
					{ name = "luasnip", keyword_length = 3 },
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
