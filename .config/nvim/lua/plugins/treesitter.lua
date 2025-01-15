return {
	url = "https://www.github.com/nvim-treesitter/nvim-treesitter",
	name = "nvim-treesitter",
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-refactor",
		{
			url = "https://www.github.com/nvim-treesitter/nvim-treesitter-context",
			opts = {
				enable = true,
				max_lines = 1,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 1,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = nil,
			},
		},
		{
			url = "https://www.github.com/JoosepAlviste/nvim-ts-context-commentstring",
			opts = {
				enable_autocmd = false,
			},
			init = function()
				local get_option = vim.filetype.get_option
				vim.filetype.get_option = function(filetype, option)
					return option == "commentstring"
							and require("ts_context_commentstring.internal").calculate_commentstring()
						or get_option(filetype, option)
				end
			end,
		},
	},
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	end,
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			sync_install = true,
			modules = {},
			ignore_install = {},
			ensure_installed = {
				"bash",
				"bibtex",
				"c",
				"csv",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"gpg",
				"ini",
				"json",
				"latex",
				"lua",
				"make",
				"markdown_inline",
				"perl",
				"psv",
				"python",
				"pymanifest",
				"readline",
				"requirements",
				"ssh_config",
				"tsv",
				"query",
				"yaml",
				"tmux",
				"toml",
				"vimdoc",
				"vim",
				"xml",
				"zathurarc",
			},
			auto_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<M-space>",
				},
			},
			injection = {
			  enable = true,
			  custom_injections = {
			    ["latex"] = {
			      ["python"] = "python",
			      ["pythonq"] = "python",
			      ["pythonrepl"] = "python",
			      ["luacode"] = "lua",
          },
        },
      },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
