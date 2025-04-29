local util = require("util")
return {
	{
		url = "https://www.github.com/neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		init = function()
			local lspconfig = require("lspconfig")

			lspconfig.matlab_ls.setup({
				settings = {
					cmd = { "/usr/bin/matlab-language-server", "--stdio" },
					filetypes = { "matlab" },
					matlab = {
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
						indexWorkspace = true,
						installPath = "/home/air/.local/bin/share/MATLAB/R2024a",
					},
					single_file_support = true,
				},
			})

			lspconfig.bashls.setup({
				single_file_support = true,
				settings = {
					bashIde = {
						globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
					},
				},
			})
			lspconfig.rust_analyzer.setup({
				single_file_support = true,
			})

			lspconfig.lua_ls.setup({
				single_file_support = false,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						hint = {
							enable = true,
						},
						workspace = {
							checkThirdParty = true,
						},
						format = {
							enable = true,
						},
						diagnostics = {
							globals = { "vim" },
							neededFileStatus = "Any",
						},
						telemetry = { enable = false },
					},
					log_level = vim.lsp.protocol.MessageType.Info,
				},
				docs = {
					description = { "LuaLS" },
				},
			})

			lspconfig.systemd_ls.setup({})

			local ruff = lspconfig.ruff.setup({
				name = "ruff",
				cmd = { "/home/air/.local/share/virtualenvs/neovim/bin/ruff", "server" }, -- TODO get this working properly
				single_file_support = true,
				settings = {
					init_options = {
						settings = {
							logLevel = "debug",
							analyze = {
								preview = true,
							},
							format = {
								line_length = vim.bo.textwidth,
								indent_width = vim.bo.shiftwidth,
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
			})

			local pylsp = lspconfig.pylsp.setup({
				name = "pylsp",
				cmd = { vim.fn.expand("~/.local/share/virtualenvs/neovim/bin/pylsp") },
				single_file_support = true,
				settings = {
					pylsp = {
						filetypes = { "python" },
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
								completions = { enabled = false },
								code_actions = { enabled = true },
							},
						},
					},
				},
				docs = {
					description = { "Pylsp" },
				},
			})

			-- Disable Ruff hover capability in favor of Pylsp
			if ruff and pylsp then
				for _, client in ipairs(vim.lsp.get_clients({ id = ruff })) do
					client.server_capabilities.hoverProvider = false
					client.server_capabilities.codeActionProvider = false
				end
				for _, client in ipairs(vim.lsp.get_clients({ id = pylsp })) do
					for _, capability in ipairs(client.server_capabilities) do
						if
							not capability == client.server_capabilities.hoverProvider
							or not capability == client.server_capabilities.codeActionProvider
						then
							capability = false
						end
					end
				end
			end

			lspconfig.texlab.setup({
				settings = {
					texlab = {
						build = {
							-- executable = "latexmk",
							executable = nil,
							args = {},
							forwardSearchAfter = false,
							onSave = false,
							useFileList = false,
						},
						chktex = {
							onEdit = false,
							onOpenAndSave = false,
							additionalArgs = { "-v", "1" },
						},
						diagnosticsDelay = 10,
						bibtexFormatter = "latexindent",
						formatterLineLength = 80,
						forwardSearch = {
							executable = "/bin/zathura",
							args = { "--synctex-forward", "%l:1:%f", "%p" },
						},
						latexFormatter = "latexindent",
						latexindent = {
							modifyLineBreaks = true,
							replacement = "-rv",
						},
						completion = {
							matcher = "fuzzy-ignore-case",
						},
						experimental = {
							followPackageLinks = true,
						},
					},
				},
			})
		end,
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspAttachGroup", { clear = true }),
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					local bufnr = vim.api.nvim_get_current_buf()

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_codeAction) then
						util.nmap("<leader>ca", vim.lsp.buf.code_action, bufnr, "[C]ode [A]ction")
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_declaration) then
						util.nmap("gD", vim.lsp.buf.declaration, bufnr, "[G]oto [D]eclaration")
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_definition) then
						util.nmap("gd", vim.lsp.buf.definition, bufnr, "[G]oto [D]efinition")
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentSymbol) then
						util.nmap("<leader>ds", vim.lsp.buf.document_symbol, bufnr, "[D]ocument [S]ymbols")
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_hover) then
						util.nmap("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_implementation) then
						util.nmap("gI", vim.lsp.buf.implementation, bufnr, "[G]oto [I]mplementation")
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_references) then
						util.nmap("gr", vim.lsp.buf.references, bufnr, "[G]oto [R]eferences")
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_rename) then
						util.nmap("<leader>rn", vim.lsp.buf.rename, bufnr, "[R]e[n]ame")
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp) then
						util.nmap("<C-k>", vim.lsp.buf.signature_help, bufnr, "Signature Documentation")
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_typeDefinition) then
						util.nmap("<leader>D", vim.lsp.buf.type_definition, bufnr, "Type [D]efinition")
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.workspace_workspaceFolders) then
						util.nmap("<leader>wl", function()
							print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
						end, bufnr, "[W]orkspace [L]ist Folders")
						util.nmap(
							"<leader>wr",
							vim.lsp.buf.remove_workspace_folder,
							bufnr,
							"[W]orkspace [R]emove Folder"
						)
						util.nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, bufnr, "[W]orkspace [A]dd Folder")
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.workspace_symbol) then
						util.nmap("<leader>ds", vim.lsp.buf.workspace_symbol, bufnr, "[W]orkspace [S]ymbols")
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup = vim.api.nvim_create_augroup("LspHighlightGroup", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("LspDetachGroup", { clear = true }),
							callback = function(args)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = args.buf })
							end,
						})
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						util.nmap("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, vim.api.nvim_get_current_buf(), "[T]oggle Inlay [H]ints")
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		end,
	},
	{
		url = "http://www.github.com/mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				sh = { "shellcheck" },
				python = { "ruff" },
				lua = { "selene" },
				tex = { "chktex" },
				c = { "clangtidy" },
			}

			lint.linters.shellcheck.args = {
				"-a",
				"-x",
			}

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
				pattern = "*",
				group = vim.api.nvim_create_augroup("LintGroup", { clear = true }),
				callback = function()
					if vim.bo.modifiable then
						lint.try_lint()
					end
				end,
			})
		end,
	},
	{
		url = "http://www.github.com/jmbuhr/otter.nvim",
		dependencies = {
			{ url = "https://www.github.com/neovim/nvim-lspconfig" },
		},
		event = "VeryLazy",
		opts = {
			lsp = {
				diagnostic_update_events = { "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" },
				root_dir = function(_, bufnr)
					return vim.fs.root(bufnr or 0, {
						".git",
						".latexmkrc",
					}) or vim.fn.getcwd(0)
				end,
			},
			buffers = {
				set_filetype = true,
				write_to_disk = true,
			},
			strip_wrapping_quote_characters = { "'", '"', "`" },
			handle_leading_whitespace = true,
		},
		config = function()
			local otter = require("otter")
			local languages = { "lua", "python" }
			local completion = true
			local diagnostics = true
			local tsquery = nil
			otter.activate(languages, completion, diagnostics, tsquery)
		end,
	},
	{
		url = "https://www.github.com/stevearc/conform.nvim",
		event = "VeryLazy",
		cmd = { "ConformInfo" },
		opts = {
			formatters = {
				shfmt = {
					prepend_args = { "-s", "-bn", "-ci", "-sr" },
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				python = { "ruff_format", "ruff_organize_imports" },
				tex = { "tex-fmt", "injected" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
		init = function()
			local conform = require("conform")
			conform.formatters.injected = {
				ignore_errors = false,
				lang_to_ext = {
					lua = "lua",
					python = "py",
				},
			}
		end,
	},
}
