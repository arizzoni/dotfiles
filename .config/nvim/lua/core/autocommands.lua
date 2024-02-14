-- [[ Autocommands ]]

-- Start terminal in insert mode
-- TODO: get colored prompt working in neovide
local term_enter_group = vim.api.nvim_create_augroup("TerminalEnter", { clear = true })
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = { "*" },
  group = term_enter_group,
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.g.termguicolors = true
      vim.cmd("startinsert")
      vim.o.number = false
      vim.o.relativenumber = false
    end
  end
})

-- Close terminal when shell exits
local term_exit_group = vim.api.nvim_create_augroup("TerminalExit", { clear = true })
vim.api.nvim_create_autocmd("TermClose", {
  group = term_exit_group,
  callback = function()
    vim.cmd("bdelete")
  end
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})
