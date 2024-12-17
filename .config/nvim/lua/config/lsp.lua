local util = require('util')

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		local bufnr = vim.fn.bufnr()
		util.nmap("<leader>rn", vim.lsp.buf.rename, bufnr, "[R]e[n]ame")
		util.nmap("<leader>ca", vim.lsp.buf.code_action, bufnr, "[C]ode [A]ction")
		util.nmap("gd", vim.lsp.buf.definition, bufnr, "[G]oto [D]efinition")
		util.nmap("gr", vim.lsp.buf.references, bufnr, "[G]oto [R]eferences")
		util.nmap("gI", vim.lsp.buf.implementation, bufnr, "[G]oto [I]mplementation")
		util.nmap("<leader>D", vim.lsp.buf.type_definition, bufnr, "Type [D]efinition")
		util.nmap("<leader>ds", vim.lsp.buf.document_symbol, bufnr, "[D]ocument [S]ymbols")
		util.nmap("<leader>ds", vim.lsp.buf.workspace_symbol, bufnr, "[W]orkspace [S]ymbols")
		util.nmap("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
		util.nmap("<C-k>", vim.lsp.buf.signature_help, bufnr, "Signature Documentation")
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
})
