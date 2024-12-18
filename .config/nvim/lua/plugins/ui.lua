local util = require("util")

return {
  {
    url = "https://www.github.com/akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.382 -- 1/(Golden Ratio)
        end
      end,
      open_mapping = nil,
      hide_numbers = true,
      autochdir = false,
      shade_terminals = false,
      start_in_insert = true,
      insert_mappings = false,
      terminal_mappings = true,
      persist_size = false,
      persist_mode = false,
      direction = "vertical",
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
    },
    init = function()
      local ipy_cmd = function()
        if os.getenv("VIRTUAL_ENV") ~= nil then
          return os.getenv("VIRTUAL_ENV") .. "/bin/ipython"
        elseif os.getenv("WORKON_HOME") ~= nil then
          return os.getenv("WORKON_HOME") .. "/ipython/bin/ipython"
        else
          return "ipython"
        end
      end

      local Terminal = require("toggleterm.terminal").Terminal
      local ipython = Terminal:new({ cmd = ipy_cmd(), hidden = true })
      local bash = Terminal:new({ cmd = "bash", hidden = true })

      repl_toggle = function()
        if vim.bo.filetype == "python" then
          ipython:toggle()
        else
          bash:toggle()
        end
      end

      util.nmap(
        [[<C-enter>]],
        repl_toggle,
        vim.api.nvim_get_current_buf(),
        "Toggle REPL"
      )

      util.nmap(
        "<leader>sl",
        require("toggleterm").send_lines_to_terminal,
        vim.api.nvim_get_current_buf(),
        "[S]end Selected [L]ine to REPL"
      )

      util.vmap(
        "<leader>sl",
        require("toggleterm").send_lines_to_terminal,
        vim.api.nvim_get_current_buf(),
        "[S]end Selected [L]ines to REPL"
      )

      util.vmap(
        "<leader>ss",
        require("toggleterm").send_lines_to_terminal,
        vim.api.nvim_get_current_buf(),
        "[S]end [S]election to REPL"
      )

      local term_enter_group = vim.api.nvim_create_augroup(
        "TerminalEnter",
        { clear = true }
      )
      vim.api.nvim_create_autocmd(
        { "TermOpen" },
        {
          pattern = { "*" },
          group = term_enter_group,
          callback = function()
            if vim.opt.buftype:get() == "terminal" then
              util.tmap(
                "<esc>",
                [[<C-\><C-n>]],
                vim.api.nvim_get_current_buf(),
                ""
              )

              util.tmap(
                "<C-w>h",
                [[<Cmd>wincmd h<CR>]],
                vim.api.nvim_get_current_buf(),
                ""
              )

              util.tmap(
                "<C-w>j",
                [[<Cmd>wincmd j<CR>]],
                vim.api.nvim_get_current_buf(),
                ""
              )

              util.tmap(
                "<C-w>k",
                [[<Cmd>wincmd k<CR>]],
                vim.api.nvim_get_current_buf(),
                ""
              )

              util.tmap(
                "<C-w>l",
                [[<Cmd>wincmd l<CR>]],
                vim.api.nvim_get_current_buf(),
                ""
              )

              util.tmap(
                "<C-w>w",
                [[<C-\><C-n><C-w>]],
                vim.api.nvim_get_current_buf(),
                ""
              )

              util.tmap(
                [[<C-enter>]],
                "<cmd>lua repl_toggle()<CR>",
                vim.api.nvim_get_current_buf(),
                ""
              )
            end
          end
        })

      -- require('util').augroup("toggleterm", function(autocmd)
      --   autocmd("WinResized", { callback = function()
      --     -- if vim.winwidth(0) > vim.winheight(0) then
      --       require('toggleterm').toggle_all()
      --       require('toggleterm').toggle_all()
      --     -- end
      --   end
      --   })
      -- end
      -- )
    end
  },
  {
    url = "https://www.github.com/nvim-lualine/lualine.nvim",
    dependencies = {
      url = "https://www.github.com/arkav/lualine-lsp-progress",
    },
    name = "lualine.nvim",
    lazy = false,
    opts = {
      options = {
        icons_enabled = false,
        theme = "auto",
        globalstatus = true,
        component_separators = "|",
        section_separators = ""
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
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "lsp_progress",
          }
        },
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
          },
          "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = { "tabs" },
        lualine_b = { "windows" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "searchcount", "selectioncount" },
        lualine_z = {
          {
            "buffers",
            mode = 3,
            symbols = {
              modified = "~",
              alternate_file = "#",
              directory = "dir"
            },
          }
        },
      },
    },
  },
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
