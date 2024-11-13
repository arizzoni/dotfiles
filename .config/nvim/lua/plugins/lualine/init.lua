-- Set lualine as statusline
return {
  url = 'https://www.github.com/nvim-lualine/lualine.nvim',
  dependencies = {
    url = 'https://www.github.com/arkav/lualine-lsp-progress',
  },
  name = "lualine.nvim",
  lazy = false,
  opts = {
    options = {
      icons_enabled = false,
      theme = 'wal',
      globalstatus = true,
      component_separators = '|',
      section_separators = ''
    },
    extensions = {
      "lazy",
      "mason",
      "man",
      "oil",
      "quickfix",
      "toggleterm",
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
      lualine_a = { 'tabs' },
      lualine_b = { 'windows' },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { 'searchcount', 'selectioncount' },
      lualine_z = {
        {
          'buffers',
          mode = 3,
          symbols = {
            modified = '~',
            alternate_file = '#',
            directory = 'dir'
          },
        }
      },
    },
  },
}
