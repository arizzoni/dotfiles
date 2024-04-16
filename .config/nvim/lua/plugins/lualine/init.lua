-- Set lualine as statusline
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'arkav/lualine-lsp-progress',
  },
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
    extensions = {
      'fugitive',
      'lazy',
      'man',
      'mason',
      'quickfix',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'lsp_progress' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
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
      lualine_b = { 'tabs' },
      lualine_c = { 'windows' },
      lualine_x = { 'searchcount', 'selectioncount' },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
