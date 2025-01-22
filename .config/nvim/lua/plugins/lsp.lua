local util = require("util")

return {
	{
		url = "https://www.github.com/neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
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

			local shellcheck = lint.linters.shellcheck
			shellcheck.args = { "-x" }

			vim.api.nvim_create_autocmd({ "LspAttach", "InsertLeave", "BufWritePost" }, {
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
				diagnostic_update_events = { "BufWritePost", "InsertLeave" },
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
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_organize_imports" },
				bash = { "shfmt" },
				latex = { "tex-fmt" },
				["*"] = { "injected" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
		init = function()
			require("conform").formatters.injected = {
				ignore_errors = false,
				lang_to_ft = {
					bash = "sh",
					latex = "tex",
					python = "py",
					lua = "lua",
				},
				lang_to_ext = {
					bash = "sh",
					latex = "tex",
					python = "py",
					lua = "lua",
				},
				lang_to_formatters = {
					lua = { "stylua" },
					python = { "ruff_format", "ruff_organize_imports" },
					bash = { "shfmt" },
					latex = { "tex-fmt" },
				},
			}
		end,
	},
}
