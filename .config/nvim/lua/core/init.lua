-- ~/.config/nvim/lua/core/init.lua
-- Neovim configuration entry script

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
