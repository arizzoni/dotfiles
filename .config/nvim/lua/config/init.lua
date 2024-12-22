require("config.options")
require("config.lsp")
local statusline = require("config.statusline")
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

local line = statusline.new()
function GetStatusLine()
  return table.concat({
    line.get_mode(),
    line.get_diagnostics(),
    line.get_filepath(),
    line.get_virtual_env(),
    line.get_git_branch(),
    "%#StatusLine#%=",
    "%#StatusLineLines# %l/%L %p%% ",
  })
end

vim.opt.statusline = "%!v:lua.GetStatusLine()"

local term = terminal.new()
