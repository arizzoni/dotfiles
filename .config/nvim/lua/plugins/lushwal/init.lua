-- Pywal Color Scheme
return {
  'oncomouse/lushwal.nvim',
  name = "lushwal.nvim",
  cmd = { "LushwalCompile" }, -- Specify command to recompile wal colors
  event = "VeryLazy",
  dependencies = {
    -- Lush colorscheming engine
    { 'rktjmp/lush.nvim' },
    -- Shipwright
    -- { 'rktjmp/shipwright.nvim' },
  },
  init = function()
    vim.g.lushwal_configuration = {
      compile_to_vimscript = false, -- if we don't compile we don't need shipwright
      addons = {
        gitsigns_nvim = true,
        indent_blankline_nvim = true,
        lualine = false,
        markdown = true,
        native_lsp = true,
        neogit = true,
        nvim_cmp = true,
        telescope_nvim = true,
        treesitter = true,
        which_key_nvim = true,
      },
    }
  end
}
