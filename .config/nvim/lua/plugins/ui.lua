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
      local julia = Terminal:new({ cmd = "julia --banner=no", hidden = true })
      local bash = Terminal:new({ cmd = "bash", hidden = true })
      local matlab = Terminal:new({ cmd = "matlab -nodesktop", hidden = true })

      repl_toggle = function()
        if vim.bo.filetype == "python" then
          ipython:toggle()
        elseif vim.bo.filetype == "julia" then
          julia:toggle()
        elseif vim.bo.filetype == "matlab" then
          matlab:toggle()
        elseif ipython:is_open() then
          ipython:toggle()
        elseif julia:is_open() then
          julia:toggle()
        elseif matlab:is_open() then
          matlab:toggle()
        else
          bash:toggle()
        end
      end

      vim.api.nvim_set_keymap("n", [[<C-enter>]], "<cmd>lua repl_toggle()<CR>",
        { noremap = true, silent = true, desc = "Toggle REPL" })
      vim.api.nvim_set_keymap("v", "<leader>sl", "<cmd>ToggleTermSendVisualLines<CR>",
        { noremap = true, silent = true, desc = "[S]end Selected [L]ines to REPL" })
      vim.api.nvim_set_keymap("n", "<leader>sl", "<cmd>ToggleTermSendCurrentLine<CR>",
        { noremap = true, silent = true, desc = "[S]end [C]urrent Line to REPL" })
      vim.api.nvim_set_keymap("v", "<leader>ss", "<cmd>ToggleTermSendVisualSelection<CR>",
        { noremap = true, silent = true, desc = "[S]end [S]election to REPL" })

      local term_enter_group = vim.api.nvim_create_augroup("TerminalEnter", { clear = true })
      vim.api.nvim_create_autocmd({ "TermOpen" }, {
        pattern = { "*" },
        group = term_enter_group,
        callback = function()
          if vim.opt.buftype:get() == "terminal" then
            util.tmap("<esc>", [[<C-\><C-n>]], vim.api.nvim_get_current_buf(), "")
            util.tmap("<C-w>h", [[<Cmd>wincmd h<CR>]], vim.api.nvim_get_current_buf(), "")
            util.tmap("<C-w>j", [[<Cmd>wincmd j<CR>]], vim.api.nvim_get_current_buf(), "")
            util.tmap("<C-w>k", [[<Cmd>wincmd k<CR>]], vim.api.nvim_get_current_buf(), "")
            util.tmap("<C-w>l", [[<Cmd>wincmd l<CR>]], vim.api.nvim_get_current_buf(), "")
            util.tmap("<C-w>w", [[<C-\><C-n><C-w>]], vim.api.nvim_get_current_buf(), "")
            util.tmap([[<C-enter>]], "<cmd>lua repl_toggle()<CR>", vim.api.nvim_get_current_buf(), "")
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
    url = "https://www.github.com/nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    name = "telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      {
        url = "https://www.github.com/nvim-lua/plenary.nvim",
        event = "VeryLazy",
      },
      {
        url = "https://www.github.com/nvim-telescope/telescope-symbols.nvim",
        event = "VeryLazy",
      },
      {
        url = "https://www.github.com/nvim-telescope/telescope-dap.nvim",
        event = "VeryLazy",
      },
      {
        url = "https://www.github.com/nvim-telescope/telescope-ui-select.nvim",
        event = "VeryLazy",
      },
      {
        url = "https://www.github.com/nvim-telescope/telescope-fzy-native.nvim",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
      {
        url = "https://www.github.com/jalvesaq/dict.nvim",
        event = "VeryLazy",
        config = {},
      },
    },
    opts = {
      defaults = {
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
    },
    init = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_cursor {}
          },
        },
      })
      require("telescope").load_extension("fzy_native")
      require("telescope").load_extension("dap")
      require("telescope").load_extension("ui-select")
    end,
    config = function()
      --[[ Telescope Keymaps ]]
      local pickers = require("telescope.builtin")
      local themes = require("telescope.themes")
      local border = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }

      if pickers ~= nil and themes ~= nil then
        util.nmap("<leader>?", function()
          pickers.oldfiles(themes.get_ivy {
            borderchars = border,
          })
        end, vim.api.nvim_get_current_buf(), "[?] Find recently opened files")

        util.nmap("<leader><space>", function()
          pickers.buffers(themes.get_ivy {
            borderchars = border,
          })
        end, vim.api.nvim_get_current_buf(), "[ ] Find existing buffers")

        util.nmap("<leader>/", function()
          pickers.current_buffer_fuzzy_find(themes.get_cursor {
            previewer = false,
            borderchars = border,
          })
        end, vim.api.nvim_get_current_buf(), "[/] Fuzzily search in current buffer")

        util.nmap("<leader>gf", function()
          pickers.git_files(themes.get_ivy {
            borderchars = border,
          })
        end, vim.api.nvim_get_current_buf(), "Search [G]it [F]iles")

        util.nmap("<leader>sf", function()
          pickers.find_files(themes.get_ivy {
            borderchars = border,
          })
        end, vim.api.nvim_get_current_buf(), "[S]earch [F]iles")

        util.nmap("<leader>sh", function()
          pickers.help_tags(themes.get_ivy {
            borderchars = border,
          })
        end, vim.api.nvim_get_current_buf(), "[S]earch [H]elp")

        util.nmap("<leader>sw", function()
          pickers.grep_string(themes.get_cursor {
            previewer = false,
            borderchars = border,
          })
        end, vim.api.nvim_get_current_buf(), "[S]earch current [W]ord")

        util.nmap("<leader>sg", function()
          pickers.live_grep(themes.get_ivy {
            borderchars = border,
          })
        end, vim.api.nvim_get_current_buf(), "[S]earch by [G]rep")

        util.nmap("<leader>sd", function()
          pickers.diagnostics(themes.get_ivy {
            previewer = false,
            borderchars = border,
          })
        end, vim.api.nvim_get_current_buf(), "[S]earch [D]iagnostics")

        util.nmap("<leader>k", function()
          require("dict").lookup()
        end, vim.api.nvim_get_current_buf(), "Dictionary Loo[k]up")
      end
    end
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
      local actions = require("diffview.actions")
      require("diffview").setup({
        diff_binaries = false,    -- Show diffs for binaries
        enhanced_diff_hl = false, -- See |diffview-config-enhanced_diff_hl|
        git_cmd = { "git" },      -- The git executable followed by default args.
        hg_cmd = { "hg" },        -- The hg executable followed by default args.
        use_icons = true,         -- Requires nvim-web-devicons
        show_help_hints = true,   -- Show hints for how to open the help panel
        watch_index = true,       -- Update views and index buffers when the git index changes.
        icons = {                 -- Only applies when use_icons is true.
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
        view = {
          -- Configure the layout and behavior of different types of views.
          -- Available layouts:
          --  'diff1_plain'
          --    |'diff2_horizontal'
          --    |'diff2_vertical'
          --    |'diff3_horizontal'
          --    |'diff3_vertical'
          --    |'diff3_mixed'
          --    |'diff4_mixed'
          -- For more info, see |diffview-config-view.x.layout|.
          default = {
            -- Config for changed files, and staged files in diff views.
            layout = "diff2_horizontal",
            disable_diagnostics = true, -- Temporarily disable diagnostics for diff buffers while in the view.
            winbar_info = false,        -- See |diffview-config-view.x.winbar_info|
          },
          merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = "diff3_horizontal",
            disable_diagnostics = true, -- Temporarily disable diagnostics for diff buffers while in the view.
            winbar_info = true,         -- See |diffview-config-view.x.winbar_info|
          },
          file_history = {
            -- Config for changed files in file history views.
            layout = "diff2_horizontal",
            disable_diagnostics = true, -- Temporarily disable diagnostics for diff buffers while in the view.
            winbar_info = false,        -- See |diffview-config-view.x.winbar_info|
          },
        },
        file_panel = {
          listing_style = "tree",            -- One of 'list' or 'tree'
          tree_options = {                   -- Only applies when listing_style is 'tree'
            flatten_dirs = true,             -- Flatten dirs that only contain one single dir
            folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
          },
          win_config = {                     -- See |diffview-config-win_config|
            position = "left",
            width = 35,
            win_opts = {},
          },
        },
        file_history_panel = {
          log_options = { -- See |diffview-config-log_options|
            git = {
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
            hg = {
              single_file = {},
              multi_file = {},
            },
          },
          win_config = { -- See |diffview-config-win_config|
            position = "bottom",
            height = 16,
            win_opts = {},
          },
        },
        commit_log_panel = {
          win_config = {}, -- See |diffview-config-win_config|
        },
        default_args = {   -- Default args prepended to the arg-list for the listed commands
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },
        hooks = {},                 -- See |diffview-config-hooks|
        keymaps = {
          disable_defaults = false, -- Disable the default keymaps
          view = {
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            { "n", "<tab>",      actions.select_next_entry,             { desc = "Open the diff for the next file" } },
            { "n", "<s-tab>",    actions.select_prev_entry,             { desc = "Open the diff for the previous file" } },
            { "n", "[F",         actions.select_first_entry,            { desc = "Open the diff for the first file" } },
            { "n", "]F",         actions.select_last_entry,             { desc = "Open the diff for the last file" } },
            { "n", "gf",         actions.goto_file_edit,                { desc = "Open the file in the previous tabpage" } },
            { "n", "<C-w><C-f>", actions.goto_file_split,               { desc = "Open the file in a new split" } },
            { "n", "<C-w>gf",    actions.goto_file_tab,                 { desc = "Open the file in a new tabpage" } },
            { "n", "<leader>e",  actions.focus_files,                   { desc = "Bring focus to the file panel" } },
            { "n", "<leader>b",  actions.toggle_files,                  { desc = "Toggle the file panel." } },
            { "n", "g<C-x>",     actions.cycle_layout,                  { desc = "Cycle through available layouts." } },
            { "n", "[x",         actions.prev_conflict,                 { desc = "In the merge-tool: jump to the previous conflict" } },
            { "n", "]x",         actions.next_conflict,                 { desc = "In the merge-tool: jump to the next conflict" } },
            { "n", "<leader>co", actions.conflict_choose("ours"),       { desc = "Choose the OURS version of a conflict" } },
            { "n", "<leader>ct", actions.conflict_choose("theirs"),     { desc = "Choose the THEIRS version of a conflict" } },
            { "n", "<leader>cb", actions.conflict_choose("base"),       { desc = "Choose the BASE version of a conflict" } },
            { "n", "<leader>ca", actions.conflict_choose("all"),        { desc = "Choose all the versions of a conflict" } },
            { "n", "dx",         actions.conflict_choose("none"),       { desc = "Delete the conflict region" } },
            { "n", "<leader>cO", actions.conflict_choose_all("ours"),   { desc = "Choose the OURS version of a conflict for the whole file" } },
            { "n", "<leader>cT", actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
            { "n", "<leader>cB", actions.conflict_choose_all("base"),   { desc = "Choose the BASE version of a conflict for the whole file" } },
            { "n", "<leader>cA", actions.conflict_choose_all("all"),    { desc = "Choose all the versions of a conflict for the whole file" } },
            { "n", "dX",         actions.conflict_choose_all("none"),   { desc = "Delete the conflict region for the whole file" } },
          },
          diff1 = {
            -- Mappings in single window diff layouts
            { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
          },
          diff2 = {
            -- Mappings in 2-way diff layouts
            { "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
          },
          diff3 = {
            -- Mappings in 3-way diff layouts
            { { "n", "x" }, "2do", actions.diffget("ours"),           { desc = "Obtain the diff hunk from the OURS version of the file" } },
            { { "n", "x" }, "3do", actions.diffget("theirs"),         { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
            { "n",          "g?",  actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
          },
          diff4 = {
            -- Mappings in 4-way diff layouts
            { { "n", "x" }, "1do", actions.diffget("base"),           { desc = "Obtain the diff hunk from the BASE version of the file" } },
            { { "n", "x" }, "2do", actions.diffget("ours"),           { desc = "Obtain the diff hunk from the OURS version of the file" } },
            { { "n", "x" }, "3do", actions.diffget("theirs"),         { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
            { "n",          "g?",  actions.help({ "view", "diff4" }), { desc = "Open the help panel" } },
          },
          file_panel = {
            { "n", "j",             actions.next_entry,                    { desc = "Bring the cursor to the next file entry" } },
            { "n", "<down>",        actions.next_entry,                    { desc = "Bring the cursor to the next file entry" } },
            { "n", "k",             actions.prev_entry,                    { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<up>",          actions.prev_entry,                    { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<cr>",          actions.select_entry,                  { desc = "Open the diff for the selected entry" } },
            { "n", "o",             actions.select_entry,                  { desc = "Open the diff for the selected entry" } },
            { "n", "l",             actions.select_entry,                  { desc = "Open the diff for the selected entry" } },
            { "n", "<2-LeftMouse>", actions.select_entry,                  { desc = "Open the diff for the selected entry" } },
            { "n", "-",             actions.toggle_stage_entry,            { desc = "Stage / unstage the selected entry" } },
            { "n", "s",             actions.toggle_stage_entry,            { desc = "Stage / unstage the selected entry" } },
            { "n", "S",             actions.stage_all,                     { desc = "Stage all entries" } },
            { "n", "U",             actions.unstage_all,                   { desc = "Unstage all entries" } },
            { "n", "X",             actions.restore_entry,                 { desc = "Restore entry to the state on the left side" } },
            { "n", "L",             actions.open_commit_log,               { desc = "Open the commit log panel" } },
            { "n", "zo",            actions.open_fold,                     { desc = "Expand fold" } },
            { "n", "h",             actions.close_fold,                    { desc = "Collapse fold" } },
            { "n", "zc",            actions.close_fold,                    { desc = "Collapse fold" } },
            { "n", "za",            actions.toggle_fold,                   { desc = "Toggle fold" } },
            { "n", "zR",            actions.open_all_folds,                { desc = "Expand all folds" } },
            { "n", "zM",            actions.close_all_folds,               { desc = "Collapse all folds" } },
            { "n", "<c-b>",         actions.scroll_view(-0.25),            { desc = "Scroll the view up" } },
            { "n", "<c-f>",         actions.scroll_view(0.25),             { desc = "Scroll the view down" } },
            { "n", "<tab>",         actions.select_next_entry,             { desc = "Open the diff for the next file" } },
            { "n", "<s-tab>",       actions.select_prev_entry,             { desc = "Open the diff for the previous file" } },
            { "n", "[F",            actions.select_first_entry,            { desc = "Open the diff for the first file" } },
            { "n", "]F",            actions.select_last_entry,             { desc = "Open the diff for the last file" } },
            { "n", "gf",            actions.goto_file_edit,                { desc = "Open the file in the previous tabpage" } },
            { "n", "<C-w><C-f>",    actions.goto_file_split,               { desc = "Open the file in a new split" } },
            { "n", "<C-w>gf",       actions.goto_file_tab,                 { desc = "Open the file in a new tabpage" } },
            { "n", "i",             actions.listing_style,                 { desc = "Toggle between 'list' and 'tree' views" } },
            { "n", "f",             actions.toggle_flatten_dirs,           { desc = "Flatten empty subdirectories in tree listing style" } },
            { "n", "R",             actions.refresh_files,                 { desc = "Update stats and entries in the file list" } },
            { "n", "<leader>e",     actions.focus_files,                   { desc = "Bring focus to the file panel" } },
            { "n", "<leader>b",     actions.toggle_files,                  { desc = "Toggle the file panel" } },
            { "n", "g<C-x>",        actions.cycle_layout,                  { desc = "Cycle available layouts" } },
            { "n", "[x",            actions.prev_conflict,                 { desc = "Go to the previous conflict" } },
            { "n", "]x",            actions.next_conflict,                 { desc = "Go to the next conflict" } },
            { "n", "g?",            actions.help("file_panel"),            { desc = "Open the help panel" } },
            { "n", "<leader>cO",    actions.conflict_choose_all("ours"),   { desc = "Choose the OURS version of a conflict for the whole file" } },
            { "n", "<leader>cT",    actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
            { "n", "<leader>cB",    actions.conflict_choose_all("base"),   { desc = "Choose the BASE version of a conflict for the whole file" } },
            { "n", "<leader>cA",    actions.conflict_choose_all("all"),    { desc = "Choose all the versions of a conflict for the whole file" } },
            { "n", "dX",            actions.conflict_choose_all("none"),   { desc = "Delete the conflict region for the whole file" } },
          },
          file_history_panel = {
            { "n", "g!",            actions.options,                    { desc = "Open the option panel" } },
            { "n", "<C-A-d>",       actions.open_in_diffview,           { desc = "Open the entry under the cursor in a diffview" } },
            { "n", "y",             actions.copy_hash,                  { desc = "Copy the commit hash of the entry under the cursor" } },
            { "n", "L",             actions.open_commit_log,            { desc = "Show commit details" } },
            { "n", "X",             actions.restore_entry,              { desc = "Restore file to the state from the selected entry" } },
            { "n", "zo",            actions.open_fold,                  { desc = "Expand fold" } },
            { "n", "zc",            actions.close_fold,                 { desc = "Collapse fold" } },
            { "n", "h",             actions.close_fold,                 { desc = "Collapse fold" } },
            { "n", "za",            actions.toggle_fold,                { desc = "Toggle fold" } },
            { "n", "zR",            actions.open_all_folds,             { desc = "Expand all folds" } },
            { "n", "zM",            actions.close_all_folds,            { desc = "Collapse all folds" } },
            { "n", "j",             actions.next_entry,                 { desc = "Bring the cursor to the next file entry" } },
            { "n", "<down>",        actions.next_entry,                 { desc = "Bring the cursor to the next file entry" } },
            { "n", "k",             actions.prev_entry,                 { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<up>",          actions.prev_entry,                 { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<cr>",          actions.select_entry,               { desc = "Open the diff for the selected entry" } },
            { "n", "o",             actions.select_entry,               { desc = "Open the diff for the selected entry" } },
            { "n", "l",             actions.select_entry,               { desc = "Open the diff for the selected entry" } },
            { "n", "<2-LeftMouse>", actions.select_entry,               { desc = "Open the diff for the selected entry" } },
            { "n", "<c-b>",         actions.scroll_view(-0.25),         { desc = "Scroll the view up" } },
            { "n", "<c-f>",         actions.scroll_view(0.25),          { desc = "Scroll the view down" } },
            { "n", "<tab>",         actions.select_next_entry,          { desc = "Open the diff for the next file" } },
            { "n", "<s-tab>",       actions.select_prev_entry,          { desc = "Open the diff for the previous file" } },
            { "n", "[F",            actions.select_first_entry,         { desc = "Open the diff for the first file" } },
            { "n", "]F",            actions.select_last_entry,          { desc = "Open the diff for the last file" } },
            { "n", "gf",            actions.goto_file_edit,             { desc = "Open the file in the previous tabpage" } },
            { "n", "<C-w><C-f>",    actions.goto_file_split,            { desc = "Open the file in a new split" } },
            { "n", "<C-w>gf",       actions.goto_file_tab,              { desc = "Open the file in a new tabpage" } },
            { "n", "<leader>e",     actions.focus_files,                { desc = "Bring focus to the file panel" } },
            { "n", "<leader>b",     actions.toggle_files,               { desc = "Toggle the file panel" } },
            { "n", "g<C-x>",        actions.cycle_layout,               { desc = "Cycle available layouts" } },
            { "n", "g?",            actions.help("file_history_panel"), { desc = "Open the help panel" } },
          },
          option_panel = {
            { "n", "<tab>", actions.select_entry,         { desc = "Change the current option" } },
            { "n", "q",     actions.close,                { desc = "Close the panel" } },
            { "n", "g?",    actions.help("option_panel"), { desc = "Open the help panel" } },
          },
          help_panel = {
            { "n", "q",     actions.close, { desc = "Close help menu" } },
            { "n", "<esc>", actions.close, { desc = "Close help menu" } },
          },
        },
      })
    end
  },
}
