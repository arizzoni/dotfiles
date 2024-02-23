-- Set lualine as statusline
return {
  'nvim-lualine/lualine.nvim',
  name = "lualine.nvim",
  lazy = false,
  opts = {
    options = {
      icons_enabled = false,
      theme = 'pywal',
      globalstatus = true,
      component_separators = '|',
      section_separators = ''
    },
    tabline = {
      lualine_a = {
        {
          'buffers',
          mode = 1,
          path = 3,
          use_mode_colors = true,
        }
      },
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'branch' }
    },
    extensions = {
      'fugitive',
      'fzf',
      'lazy',
      'man',
      'mason',
    },
  },
}
