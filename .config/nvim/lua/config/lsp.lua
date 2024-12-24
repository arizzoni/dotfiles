local util = require("util")

local lsp_group = vim.api.nvim_create_augroup("LSP", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	pattern = "*",
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = vim.api.nvim_get_current_buf()

		if client.supports_method("textDocument/codeAction") then
			util.nmap("<leader>ca", vim.lsp.buf.code_action, bufnr, "[C]ode [A]ction")
		end

		if client.supports_method("textDocument/declaration") then
			util.nmap("gD", vim.lsp.buf.declaration, bufnr, "[G]oto [D]eclaration")
		end

		if client.supports_method("textDocument/definition") then
			util.nmap("gd", vim.lsp.buf.definition, bufnr, "[G]oto [D]efinition")
		end

		if client.supports_method("textDocument/documentSymbol") then
			util.nmap("<leader>ds", vim.lsp.buf.document_symbol, bufnr, "[D]ocument [S]ymbols")
		end

		if client.supports_method("textDocument/hover") then
			util.nmap("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
		end

		if client.supports_method("textDocument/implementation") then
			util.nmap("gI", vim.lsp.buf.implementation, bufnr, "[G]oto [I]mplementation")
		end

		if client.supports_method("textDocument/references") then
			util.nmap("gr", vim.lsp.buf.references, bufnr, "[G]oto [R]eferences")
		end

		if client.supports_method("textDocument/rename") then
			util.nmap("<leader>rn", vim.lsp.buf.rename, bufnr, "[R]e[n]ame")
		end

		if client.supports_method("textDocument/signatureHelp") then
			util.nmap("<C-k>", vim.lsp.buf.signature_help, bufnr, "Signature Documentation")
		end

		if client.supports_method("textDocument/typeDefinition") then
			util.nmap("<leader>D", vim.lsp.buf.type_definition, bufnr, "Type [D]efinition")
		end

		if client.supports_method("workspace/workspaceFolders") then
			util.nmap("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, bufnr, "[W]orkspace [L]ist Folders")
			util.nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, bufnr, "[W]orkspace [R]emove Folder")
			util.nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, bufnr, "[W]orkspace [A]dd Folder")
		end

		if client.supports_method("workspace/workspaceSymbol") then
			util.nmap("<leader>ds", vim.lsp.buf.workspace_symbol, bufnr, "[W]orkspace [S]ymbols")
		end

		if not require("conform") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = lsp_group,
				pattern = "*",
				callback = function()
					if vim.lsp.get_clients({ bufnr = bufnr }) then
						vim.lsp.buf.format()
					end
				end,
			})
		end
	end,
})
