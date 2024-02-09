-- [[ Autocommands ]]

-- Start terminal in insert mode
-- TODO: get colored prompt working in neovide
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd("startinsert")
      vim.o.number = false
      vim.o.relativenumber = false
    end
  end
})

-- Close terminal when shell exits
vim.api.nvim_create_autocmd("TermClose", {
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
