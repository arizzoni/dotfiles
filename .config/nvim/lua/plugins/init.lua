if vim.fn.has("nvim-0.10.0") == 0 then
  vim.api.nvim_echo({
    { "Neovim >= 0.10.0 Required\n", "ErrorMsg" },
    { "Press any key to exit", "MoreMsg" },
  }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
  return {}
end

return {
  { url = "https://www.github.com/folke/lazy.nvim", version = "*" },
}
