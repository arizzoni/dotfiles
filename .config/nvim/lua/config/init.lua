-- init.lua
-- Personal neovim configuration entry script

require("config.options")
require("config.lsp")

local line = require("config.statusline")
local terminal = require("config.terminal")

terminal.new()

vim.cmd.colorscheme("ts_termcolors")

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
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = statusline_group,
	pattern = "*",
	callback = function()
		if vim.api.nvim_buf_get_option(0, "buftype") == "" then
			line:render()
		else
			vim.wo.statusline = " "
		end
	end,
})
