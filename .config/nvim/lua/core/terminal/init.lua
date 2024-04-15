--[[ Terminal Settings ]]

-- Start terminal in insert mode
local term_enter_group = vim.api.nvim_create_augroup("TerminalEnter", { clear = true })
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = { "*" },
  group = term_enter_group,
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.o.number = false
      vim.o.relativenumber = false
    end
  end
})

vim.keymap.set("n", "<leader>T", function()
  vim.cmd(":term")
end, { desc = "Launch [T]erminal" })
