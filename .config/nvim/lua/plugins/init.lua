if vim.fn.has("nvim-0.9.0") == 0 then
  vim.api.nvim_echo({
    { "Neovim >= 0.9.0 Required\n", "ErrorMsg" },
    { "Press any key to exit", "MoreMsg" },
  }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
  return {}
end

return {
  { "folke/lazy.nvim", version = "*" },
}
