-- options.lua
-- Neovim options configuration

local uname = vim.uv.os_uname()
if uname.sysname == "Windows" then
	vim.opt.shell = "powershell.exe"
else
	vim.opt.shell = "/bin/bash"
end

vim.o.title = true
vim.o.writebackup = true
vim.o.undofile = true
vim.o.timeout = true
vim.o.timeoutlen = 250
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
		local current_window = vim.api.nvim_get_current_win()
		if vim.api.nvim_buf_get_option(0, "buftype") == "" then
			vim.o.scrolloff = math.floor(0.34 * vim.api.nvim_win_get_height(current_window))
			vim.o.sidescrolloff = math.floor(0.34 * vim.api.nvim_win_get_width(current_window))
		end
	end,
})
