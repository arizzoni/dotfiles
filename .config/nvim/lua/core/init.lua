--[[ core/init.lua ]]

--[[ Settings ]]
vim.opt.updatetime = 167     -- Decrease update time
vim.g.transparent_enabled = true
vim.opt.termguicolors = true -- Make sure the terminal supports this
vim.opt.title = true

-- Backup and undo
vim.opt.writebackup = true
vim.opt.undofile = true -- Save undo history

-- Neovide Settings
if vim.g.neovide then
	vim.g.neovide_theme = 'auto'
	vim.g.neovide_transparency = 0.8
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_refresh_rate_idle = 6
	vim.g.neovide_cursor_animation_length = 0.125
	vim.g.neovide_cursor_trail_size = 0.5
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_vfx_mode = ""
end

-- Searching
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true

-- Input
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- Language support
vim.g.shell = "bash"
vim.g.python3_host_prog = vim.fn.expand("~/.local/share/virtualenvs/neovim/bin/python") -- Python executable
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Basic Settings
vim.g.autochdir = true
vim.g.browsedir = "current"
vim.opt.completeopt = "menuone,noselect"
vim.opt.signcolumn = "yes"
-- vim.wo.breakindent = true
vim.g.cmdwinheight = 3
vim.o.cmdheight = 0
vim.g.colorcolumn = "+1"
vim.wo.concealcursor = "nvc"
vim.bo.copyindent = true
vim.wo.cursorcolumn = false
vim.wo.cursorline = true
vim.wo.cursorlineopt = "number"
vim.g.equalalways = false
vim.g.expandtab = true
vim.g.fillchars = "lastline:."
vim.g.hlsearch = false
vim.g.ignorecase = true
vim.wo.linebreak = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.scroll = 0
vim.g.scrolloff = 8
vim.g.shiftround = true
vim.g.shiftwidth = 2
vim.g.showbreak = "↵"
vim.g.showcmd = false
vim.g.showtabline = 2
vim.g.sidescrolloff = 8
vim.g.smartcase = true
vim.g.splitbelow = true
vim.g.splitright = true
vim.g.timeoutlen = 300
vim.g.virtualedit = "block,insert"

-- Set some nice unicode characters for the error/etc. characters in the sign column
vim.fn.sign_define('DiagnosticSignError', { text = '󰅗', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '󰀧', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '󰏬', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '󰞋', texthl = 'DiagnosticSignHint' })

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

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- [[ Core Modules ]]
require("core.terminal")
require("core.netrw")

if require('lushwal') ~= nil then
	vim.cmd.colorscheme("lushwal")
else
	vim.cmd.colorscheme("quiet")
end
