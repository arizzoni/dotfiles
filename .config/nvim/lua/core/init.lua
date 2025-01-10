-- ~/.config/nvim/lua/core/init.lua
-- Neovim configuration entry script

local filemanager = require("core.filemanager")

filemanager.new()

vim.cmd.colorscheme("ts_termcolors")

local uname = vim.uv.os_uname()
if uname.sysname == "Windows" then
	vim.opt.shell = "powershell.exe"
else
	vim.opt.shell = "/bin/bash"
end

vim.o.title = true
vim.o.writebackup = true
vim.o.undofile = true
vim.o.signcolumn = "yes"
vim.o.breakindent = true
vim.o.cmdheight = 0
vim.o.colorcolumn = "+1"
vim.o.concealcursor = "nvc"
vim.o.copyindent = true
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.expandtab = true
vim.o.hlsearch = false
vim.o.linebreak = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftround = true
vim.o.showbreak = "↵   "
vim.g.python3_host_prog = vim.uv.fs_realpath(vim.env.WORKON_HOME .. "/neovim/bin/python")
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.browsedir = "current"
vim.g.equalalways = false
vim.g.showtabline = 0
vim.o.splitbelow = true
vim.o.splitright = true
vim.g.virtualedit = "block,insert"
vim.g.ignorecase = true
vim.g.smartcase = true

local options_group = vim.api.nvim_create_augroup("OptionsGroup", {})
vim.api.nvim_create_autocmd({ "VimEnter", "VimResized", "WinEnter", "WinResized" }, {
	pattern = "*",
	group = options_group,
	callback = function()
		local current_buffer = vim.api.nvim_get_current_buf()
		if vim.api.nvim_get_option_value("buftype", { buf = current_buffer }) == "" then
			local current_window = vim.api.nvim_get_current_win()
			vim.o.scrolloff = math.floor(0.34 * vim.api.nvim_win_get_height(current_window))
			vim.o.sidescrolloff = math.floor(0.34 * vim.api.nvim_win_get_width(current_window))
		end
	end,
})

-- Disable arrow keys
vim.keymap.set({ "n", "v", "i" }, "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<Right>", "<Nop>", { noremap = true, silent = true })

-- Prevent space in normal and visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remaps for dealing with word wrap
vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- Set some nice unicode characters for the error/etc. characters in the sign column
vim.fn.sign_define("DiagnosticSignError", { text = "×", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "∗", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "?", texthl = "DiagnosticSignHint" })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Open help in a vertical split
local help_group = vim.api.nvim_create_augroup("Help", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = help_group,
	pattern = "help",
	callback = function()
		local current_win = vim.api.nvim_get_current_win()
		local win_width = vim.api.nvim_win_get_width(current_win)
		vim.api.nvim_win_set_config(current_win, {
			width = math.max(math.floor(0.34 * win_width), vim.bo.textwidth + 4),
			split = "right",
		})
		vim.wo.colorcolumn = ""
	end,
})

-- LSP Attach
local lsp_group = vim.api.nvim_create_augroup("LSP", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	pattern = "*",
	callback = function(args)
		local util = require("util")
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		else
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
		end
	end,
})

-- LSP Detach
vim.api.nvim_create_autocmd("LspDetach", {
	group = lsp_group,
	pattern = "*",
	callback = function(args)
		local client_id = args.data.client_id
		local client = vim.lsp.get_client_by_id(client_id)
		if not client then
			return
		else
			local bufnr = vim.api.nvim_get_current_buf()
			vim.diagnostic.enable(false, {
				ns_id = vim.lsp.diagnostic.get_namespace(client_id, false),
				bufnr = bufnr,
			})

			if client.supports_method("textDocument/codeAction") then
				vim.api.nvim_buf_del_keymap(bufnr, "n", "<leader>ca")
			end

			if client.supports_method("textDocument/declaration") then
				vim.api.nvim_buf_del_keymap(bufnr, "n", "gD")
			end

			if client.supports_method("textDocument/definition") then
				vim.api.nvim_buf_del_keymap(bufnr, "n", "gd")
			end

			if client.supports_method("textDocument/documentSymbol") then
				vim.api.nvim_buf_del_keymap(bufnr, "n", "<leader>ds")
			end

			if client.supports_method("textDocument/hover") then
				vim.api.nvim_buf_del_keymap(bufnr, "n", "K")
			end

			if client.supports_method("textDocument/implementation") then
				vim.api.nvim_buf_del_keymap(bufnr, "n", "gI")
			end

			if client.supports_method("textDocument/references") then
				vim.api.nvim_buf_del_keymap(bufnr, "n", "gr")
			end

			if client.supports_method("textDocument/rename") then
				vim.api.nvim_buf_del_keymap(bufnr, "n", "<leader>rn")
			end

			if client.supports_method("textDocument/signatureHelp") then
				vim.api.nvim_buf_del_keymap(bufnr, "n", "<C-k>")
			end

			if client.supports_method("textDocument/typeDefinition") then
				vim.api.nvim_buf_del_keymap(bufnr, "n", "<leader>D")
			end

			if client.supports_method("workspace/workspaceFolders") then
				vim.api.nvim_buf_del_keymap(bufnr, "n", "<leader>wl")
				vim.api.nvim_buf_del_keymap(bufnr, "n", "<leader>wr")
				vim.api.nvim_buf_del_keymap(bufnr, "n", "<leader>wa")
			end

			if client.supports_method("workspace/workspaceSymbol") then
				vim.api.nvim_buf_del_keymap(bufnr, "n", "<leader>ds")
			end
		end
	end,
})

-- Statusline
local statusline_group = vim.api.nvim_create_augroup("StatusLine", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter", "TermOpen" }, {
	group = statusline_group,
	pattern = "*",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) ~= "" then
			vim.wo.statusline = " "
			vim.wo.winbar = nil
		else
			local line = require("core.statusline")
			local statusline = line.new()
			local winbar = line.new()
			function GetStatusLine()
				return table.concat({
					statusline:get_mode(),
					statusline:get_diagnostics(),
					statusline:get_lsp_info(),
					-- Horizontal fill
					"%#StatusLine#%=",
					statusline:get_file_info(),
					statusline:get_cursor_pos(),
				})
			end
			function GetWinBar()
				return table.concat({
					winbar:get_buf_number(),
					winbar:get_filepath(),
					winbar:get_git_branch(),
					-- Horizontal fill
					"%#StatusLine#%=",
					winbar:get_tab_number(),
				})
			end
			vim.wo.statusline = "%!v:lua.GetStatusLine()"
			vim.wo.winbar = "%!v:lua.GetWinBar()"
		end
	end,
})
