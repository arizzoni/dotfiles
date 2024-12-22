local util = require("util")

return {
  {
    url = "https://www.github.com/folke/which-key.nvim",
    name = "which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.timeout = true
      vim.opt.timeoutlen = 300
    end,
    opts = {
      preset = "modern",
      icons = {
        breadcrumb = "", -- symbol used in the command line area that shows your active key combo
        separator = ":", -- symbol used between a key and it's label
        group = "",      -- symbol prepended to a group,
        mappings = false,
      },
      win = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        no_overlap = true,
        border = "single",              -- none, single, double, shadow
        padding = { 1, 0 },             -- extra window padding [top, right, bottom, left]
        title = true,
        title_pos = "center",
        zindex = 1000, -- positive value to position WhichKey above other floating windows.
      },
      layout = {
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 4,                    -- spacing between columns
        align = "center",               -- align columns left, center or right
      },
    },
  },
  {
    url = "https://www.github.com/stevearc/oil.nvim",
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
  },
  {
    url = "https://www.github.com/sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function()
      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { "git" },
        hg_cmd = { "hg" },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,
        icons = {
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
        view = {
          default = {
            layout = "diff2_horizontal",
            disable_diagnostics = true,
            winbar_info = false,
          },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            disable_diagnostics = true,
            winbar_info = false,
          },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
          win_config = {
            position = "left",
            width = 35,
            win_opts = {},
          },
        },
        file_history_panel = {
          win_config = {
            position = "bottom",
            height = 16,
            win_opts = {},
          },
        },
      })
    end
  },
}
