return {
  'stevearc/oil.nvim',
  -- event = "VeryLazy",
  lazy = false,
  opts = {
    default_file_explorer = true,
    columns = {
      "size",
      "permissions",
      "mtime",
      "type",
    },
    keymaps_help = {
      border = "single",
    },
    use_default_keymaps = true,
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, ".")
      end,
      is_always_hidden = function(name, bufnr)
        return false
      end,
      natural_order = true,
      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },
    },
    float = {
      padding = 2,
      max_width = 0,
      max_height = 0,
      border = "single",
      win_options = {
        winblend = 0,
      },
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      override = function(conf)
        return conf
      end,
    },
    preview = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,
      border = "single",
      win_options = {
        winblend = 0,
      },
      update_on_cursor_moved = true,
    },
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,
      border = "single",
      minimized_border = "none",
      win_options = {
        winblend = 0,
      },
    },
    ssh = {
      border = "single",
    },
  },
}
