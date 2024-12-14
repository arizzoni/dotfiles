local util = require("util")

return {
	{
		url = "https://www.github.com/neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			{
				url = "https://www.github.com/williamboman/mason.nvim",
				config = true,
			},
			{
				url = "https://www.github.com/williamboman/mason-lspconfig.nvim"
			},
			{
				url = "https://www.github.com/folke/neodev.nvim",
				opts = {},
			},
			{
				url = "https://www.github.com/kosorin/awesome-code-doc"
			},
			{
				url = "https://www.github.com/p00f/clangd_extensions.nvim",
				opts = {},
			},
			{
				url = "https://www.github.com/nvim-telescope/telescope.nvim"
			},
			{
				url = "https://www.github.com/rshkarin/mason-nvim-lint",
				event = "VeryLazy",
				dependencies = {
					"williamboman/mason.nvim",
					"mfussenegger/nvim-lint",
				},
				opts = {
					ensure_installed = {
						"cmakelint",
						"cpplint",
						"jsonlint",
						"ruff",
						-- "shellcheck",
						"yamllint",
						"selene",
					},
					automatic_installation = false,
					handlers = {},
				},
				init = function()
					require("lint").linters_by_ft = {
						bash = { "shellcheck" },
						c = { "cpplint" },
						cmake = { "cmakelint" },
						cpp = { "cpplint" },
						json = { "jsonlint" },
						lua = { "selene" },
						python = { "ruff" },
						sh = { "shellcheck" },
						yaml = { "yamllint" },
					}

					local shellcheck = require("lint").linters.shellcheck
					shellcheck.args = {
						"-x",
					}

					vim.api.nvim_create_autocmd({ "LspAttach", "BufWritePost", "InsertLeave" }, {
						callback = function()
							require("lint").try_lint()
						end,
					})
				end,
			},
		},
		init = function()
			local pickers = require("telescope.builtin")
			local on_attach = function(_, bufnr)
				util.nmap("<leader>rn", vim.lsp.buf.rename, bufnr, "[R]e[n]ame")
				util.nmap("<leader>ca", vim.lsp.buf.code_action, bufnr, "[C]ode [A]ction")
				util.nmap("gd", vim.lsp.buf.definition, bufnr, "[G]oto [D]efinition")
				-- util.nmap("gr", vim.lsp.buf.references, bufnr, "[G]oto [R]eferences")
				util.nmap("gr", pickers.lsp_references, bufnr, "[G]oto [R]eferences")
				-- util.nmap("gI", vim.lsp.buf.implementation, bufnr, "[G]oto [I]mplementation")
				util.nmap("gI", pickers.lsp_implementations, bufnr, "[G]oto [I]mplementation")
				-- util.nmap("<leader>D", vim.lsp.buf.type_definition, bufnr, "Type [D]efinition")
				util.nmap("<leader>D", pickers.lsp_type_definitions, bufnr, "Type [D]efinition")
				-- util.nmap("<leader>ds", vim.lsp.buf.document_symbol, bufnr, "[D]ocument [S]ymbols")
				util.nmap("<leader>ds", pickers.lsp_document_symbols, bufnr, "[D]ocument [S]ymbols")
				util.nmap("<leader>ws", pickers.lsp_dynamic_workspace_symbols, bufnr, "[W]orkspace [S]ymbols")

				util.nmap("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
				util.nmap("<C-k>", vim.lsp.buf.signature_help, bufnr, "Signature Documentation")

				-- Lesser used LSP functionality
				util.nmap("gD", vim.lsp.buf.declaration, bufnr, "[G]oto [D]eclaration")
				util.nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, bufnr, "[W]orkspace [A]dd Folder")
				util.nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, bufnr, "[W]orkspace [R]emove Folder")
				util.nmap("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, bufnr, "[W]orkspace [L]ist Folders")

				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					vim.lsp.buf.format()
				end, { desc = "Format current buffer with LSP" })
			end

			require("mason").setup()

			-- Enable the following language servers
			local servers = {
				bashls = {
					bashls = {
						name = "bash-language-server",
						cmd = { "bash-language-server", "start" },
					},
				},
				clangd = {
					clangd = {
						cmd = { "clangd" },
						filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
						single_file_support = { "true" },
					},
				},
				cmake = {},
				lua_ls = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						hint = {
							enable = true,
						},
						workspace = {
							checkThirdParty = false,
							library = {
								["/home/air/.local/share/nvim/lazy/awesome-code-doc"] = true,
								[vim.env.VIMRUNTIME] = true,
							},
						},
						format = {
							enable = true,
							defaultConfig = {
								indent_style = "space",
								indent_size = "2",
								tab_width = "2",
								quote_style = "double",
								max_line_length = "120",
							},
						},
						diagnostics = {
							globals = { "vim" },
							neededFileStatus = "Any",
						},
						telemetry = { enable = false },
					},
				},
				matlab_ls = {},
				pylsp = {
					pylsp = {
						filetypes = { "py", "pytxcode" },
						plugins = {
							autopep8 = {
								enabled = false,
							},
							flake8 = {
								enabled = false,
								executable = "flake8",
							},
							pylsp_isort = {
								enabled = false,
							},
							jedi_completion = {
								enabled = true,
								fuzzy = true,
							},
							mccabe = {
								enabled = false,
							},
							pylsp_mypy = {
								enabled = false,
							},
							pycodestyle = {
								enabled = false,
							},
							pydocstyle = {
								enabled = false,
								convention = "numpy",
							},
							pyflakes = {
								enabled = false,
							},
							pylint = {
								enabled = false,
								executable = "pylint",
							},
							rope_autoimport = {
								completions = { enabled = true },
								code_actions = { enabled = true },
							},
						},
					},
				},
				ruff = {
					init_options = {
						settings = {
							logLevel = "debug",
							analyze = {
								preview = true,
							},
							format = {
								line_length = 88,
								indent_width = 4,
								indent_style = "spaces",
								quote_style = "double",
								preview = true,
							},
							lint = {
								select = {
									"E",
									"W", -- pycodestyle rules
									"C90", -- mccabe rules
									"I", -- isort rules
									"N", -- pep8-naming rules
									"D", -- pydocstyle rules
									"PL", -- pylint rules
									"NPY", -- numpy rules
									"RUF", -- ruff rules
								},
								preview = true,
								pydocstyle = {
									convention = "numpy",
								},
							},
						},
					},
				},
				texlab = {
					texlab = {
						cmd = "texlab",
						fileypes = { "tex", "plaintex", "bib" },
						settings = {
							texlab = {
								auxDirectory = "aux",
								bibtexFormatter = "texlab",
								chktex = {
									onEdit = true,
									onOpenAndSave = true,
								},
								diagnosticsDelay = 0,
								formatterLineLength = 80,
								latexFormatter = "latexindent",
								latexindent = {
									modifyLineBreaks = false,
								},
							},
						},
					},
				},
				tinymist = {
					root_dir = function(filename, bufnr)
						return vim.loop.cwd()
					end,
					settings = {
						exportPdf = "onSave",
						formatterMode = "typststyle",
						-- rootPath = "-",
					},
				},
				vhdl_ls = {},
			}

			-- nvim-cmp supports additional completion capabilities,
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- Ensure the servers above are installed
			local mason_lspconfig = require("mason-lspconfig")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client == nil then
						return
					end
					if client.name == "ruff" then
						-- Disable hover in favor of Py_lsp
						client.server_capabilities.hoverProvider = false
					end
				end,
				desc = "LSP: Disable hover capability from Ruff",
			})

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
				automatic_installation = false,
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
					})
				end,
			})
		end,
	},

	{
		url = "http://www.github.com/jmbuhr/otter.nvim",
		ft = { "tex", "typst", "tex.python" },
		event = "VeryLazy",
		opts = {
			lsp = {
				hover = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
				-- `:h events` that cause the diagnostics to update. Set to:
				-- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
				-- but more instant diagnostic updates
				diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
				root_dir = function(_, bufnr)
					return vim.fs.root(bufnr or 0, {
						".git",
						"_quarto.yml",
						"package.json",
					}) or vim.fn.getcwd(0)
				end,
			},
			buffers = {
				-- if set to true, the filetype of the otterbuffers will be set.
				-- otherwise only the autocommand of lspconfig that attaches
				-- the language server will be executed without setting the filetype
				set_filetype = true,
				-- write <path>.otter.<embedded language extension> files
				-- to disk on save of main buffer.
				-- usefule for some linters that require actual files
				-- otter files are deleted on quit or main buffer close
				write_to_disk = true,
			},
			strip_wrapping_quote_characters = { "'", '"', "`" },
			-- Otter may not work the way you expect when entire code blocks are indented (eg. in Org files)
			-- When true, otter handles these cases fully. This is a (minor) performance hit
			handle_leading_whitespace = true,
		},
		config = function()
			local otter = require("otter")
			-- table of embedded languages to look for.
			-- default = nil, which will activate
			-- any embedded languages found
			local languages = { "julia", "lua", "matlab", "python" }

			-- enable completion/diagnostics
			-- defaults are true
			local completion = true
			local diagnostics = true
			-- treesitter query to look for embedded languages
			-- uses injections if nil or not set
			local tsquery = nil

			otter.activate(languages, completion, diagnostics, tsquery)
		end,
	}
}
-- vim: ts=2 sw=2 tw=120
