-- ~/.config/nvim/lua/core/init.lua
-- Neovim configuration entry script
require("util")
require("core.search")

local term = require("core.terminal")

-- Neovide Settings
if vim.g.neovide then
	require("core.neovide")
end

local uname = vim.uv.os_uname()
if uname.sysname == "Linux" then
	vim.o.shell = "/bin/bash"
elseif uname.sysname == "Windows" then
	vim.o.shell = "powershell.exe"
else
	vim.o.shell = "/bin/sh"
end

term.new(vim.o.shell)

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
-- vim.o.expandtab = true
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
local diagnostic_opts = {
	underline = true,
	virtual_text = true,
	virtual_lines = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "×",
			[vim.diagnostic.severity.WARN] = "!",
			[vim.diagnostic.severity.INFO] = "∗",
			[vim.diagnostic.severity.HINT] = "?",
		},
	},
	update_in_insert = true,
	severity_sort = true,
}

vim.diagnostic.config(diagnostic_opts)

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

-- Keep help in vertical split on resize
vim.api.nvim_create_autocmd({ "WinResized", "VimResized" }, {
	pattern = { "*" },
	group = help_group,
	callback = function()
		if vim.bo.buftype == "help" then
			local bufnr = vim.api.nvim_get_current_buf()
			local winnr = vim.api.nvim_get_current_win()
			if vim.api.nvim_win_get_buf(winnr) == bufnr then
				local win_width = vim.api.nvim_win_get_width(winnr)
				local target_width = math.max(math.floor(0.34 * win_width), vim.bo.textwidth + 4)
				local target_height = vim.o.lines
				if vim.api.nvim_win_get_width(winnr) ~= target_width then
					vim.api.nvim_win_set_width(winnr, target_width)
				end
				if vim.api.nvim_win_get_height(winnr) ~= target_height then
					vim.api.nvim_win_set_height(winnr, target_height)
				end
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
					winbar:get_virtual_env(),
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
