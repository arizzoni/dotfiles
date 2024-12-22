-- TODO: Try to put the statuslines in an autocommand for VimOpen or similar
-- TODO: Split off a keymaps.lua?

require("config.options")
require("config.lsp")
require("config.gui")

local line = require("config.line")
local terminal = require("config.terminal")

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

local statusline = line.new()
function GetStatusLine()
	return table.concat({
		statusline.get_mode(),
		statusline.get_diagnostics(),
		statusline.get_lsp_info(),
		-- Horizontal fill
		"%#StatusLine#%=",
		statusline.get_file_info(),
		statusline.get_cursor_pos(),
	})
end

vim.opt.statusline = "%!v:lua.GetStatusLine()"

local tabline = line.new()
function GetTabLine()
	return table.concat({
		tabline.get_tab_number(),
		-- Horizontal fill
		"%#StatusLine#%=",
	})
end

vim.opt.tabline = "%!v:lua.GetTabLine()"

local winbar = line.new()
function GetWinBar()
	return table.concat({
		winbar.get_buf_number(),
		winbar.get_filepath(),
		winbar.get_git_branch(),
		-- Horizontal fill
		"%#StatusLine#%=",
	})
end

vim.opt.winbar = "%!v:lua.GetWinBar()"

terminal.new()
