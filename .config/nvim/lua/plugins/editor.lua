return {
	{
		url = "https://www.github.com/kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		url = "https://www.github.com/lervag/vimtex",
		lazy = false,
		ft = "tex",
		init = function()
			vim.g.vimtex_syntax_enabled = 0
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_format_enabled = true
			vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex" }
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
			"hrsh7th/cmp-nvim-lsp", -- LSP completion
			"hrsh7th/cmp-nvim-lsp-document-symbol", -- LSP completion
			"hrsh7th/cmp-nvim-lsp-signature-help", -- LSP completion
			"hrsh7th/cmp-buffer", -- Buffer completion
			"hrsh7th/cmp-path", -- Completion for paths
			"hrsh7th/cmp-cmdline", -- Completion for command line
			"hrsh7th/cmp-nvim-lua", -- Neovim Lua completion source
			"windwp/nvim-autopairs", -- Autopairs completion
			"micangl/cmp-vimtex", -- Vimtex completion source
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
					{ name = "buffer", keyword_length = 3 },
					{ name = "path", keyword_length = 3 },
					{ name = "cmdline", keyword_length = 3 },
					{ name = "nvim_lua", keyword_length = 3 },
					{ name = "cmp-vimtex", keyword_length = 3 },
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
		event = "VeryLazy",
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
}
