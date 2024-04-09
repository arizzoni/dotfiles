--[[ Terminal Settings ]]

-- Start terminal in insert mode
-- TODO: get colored prompt working in neovide
local term_enter_group = vim.api.nvim_create_augroup("TerminalEnter", { clear = true })
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = { "*" },
  group = term_enter_group,
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
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

vim.keymap.set("n", "<leader>tt", function()
  vim.cmd(":term")
end, { desc = "Launch Terminal ([T]ele[t]ype)" })

