-- Pywal Color Scheme
return {
  'oncomouse/lushwal.nvim',
  name = "lushwal.nvim",
  cmd = { "LushwalCompile" }, -- Specify command to recompile wal colors
  dependencies = {
    -- Lush colorscheming engine
    { 'rktjmp/lush.nvim' },
    -- Shipwright
    { 'rktjmp/shipwright.nvim' },
  },
  init = function()
    vim.g.lushwal_configuration = {
      compile_to_vimscript = false,
      color_overrides = function(colors)
        local overrides = {
          orange = colors.color1,
          purple = colors.color4,
          pink = colors.color4,
          amaranth = colors.color1,
          brown = colors.color1,
        }
        return vim.tbl_extend("force", colors, overrides)
      end,
      addons = {
        gitsigns_nvim = true,
        indent_blankline_nvim = true,
        -- lualine = true,
        markdown = true,
        native_lsp = true,
        nvim_cmp = true,
        telescope_nvim = true,
        treesitter = true,
        which_key_nvim = true,
      },
    }
  end
}
