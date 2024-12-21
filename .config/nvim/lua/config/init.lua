--[[ core/init.lua ]]

require("config.options")
require("config.lsp")
require("config.keymaps")
require("config.terminal")

vim.cmd.colorscheme("ts_termcolors")

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

-- Warning before leaving a modified buffer
local on_leave_group = vim.api.nvim_create_augroup("OnLeave", { clear = true })
vim.api.nvim_create_autocmd("BufLeave", {
  group = on_leave_group,
  pattern = "*",
  callback = function()
    if vim.api.nvim_buf_get_option(0, "modified") then
      vim.inspect(print("Warning: Unsaved Changes!"))
    end
  end,
})
