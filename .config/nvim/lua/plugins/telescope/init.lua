-- Fuzzy Finder (files, lsp, etc)
return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  name = "telescope.nvim",
  branch = "0.1.x", dependencies = {
    {
      "nvim-lua/plenary.nvim",
      event = "VeryLazy",
    },
    {
    "nvim-telescope/telescope-symbols.nvim",
      event = "VeryLazy",
    },
    {
    "nvim-telescope/telescope-dap.nvim",
      event = "VeryLazy",
    },
    {
    "nvim-telescope/telescope-ui-select.nvim",
      event = "VeryLazy",
    },
    {
      "nvim-telescope/telescope-fzy-native.nvim",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
    {
      "jalvesaq/dict.nvim",
      config = true,
    },
  },
  opts = { defaults = { borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
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
      vim.keymap.set("n", "<leader>?", function()
        pickers.oldfiles(themes.get_ivy{
          borderchars = border,
        })
      end, { desc = "[?] Find recently opened files" })

      vim.keymap.set("n", "<leader><space>", function()
        pickers.buffers(themes.get_ivy{
          borderchars = border,
        })
      end, { desc = "[ ] Find existing buffers" })

      vim.keymap.set("n", "<leader>/", function()
        pickers.current_buffer_fuzzy_find(themes.get_cursor {
          previewer = false,
          borderchars = border,
        })
      end, { desc = "[/] Fuzzily search in current buffer" })

      vim.keymap.set("n", "<leader>gf", function()
        pickers.git_files(themes.get_ivy {
          borderchars = border,
        })
      end, { desc = "Search [G]it [F]iles" })

      vim.keymap.set("n", "<leader>sf", function()
        pickers.find_files(themes.get_ivy {
          borderchars = border,
        })
      end, { desc = "[S]earch [F]iles" })

      vim.keymap.set("n", "<leader>sh", function()
        pickers.help_tags(themes.get_ivy {
          borderchars = border,
        })
      end, { desc = "[S]earch [H]elp" })

      vim.keymap.set("n", "<leader>sw", function()
        pickers.grep_string(themes.get_cursor {
          previewer = false,
          borderchars = border,
        })
      end, { desc = "[S]earch current [W]ord" })

      vim.keymap.set("n", "<leader>sg", function()
        pickers.live_grep(themes.get_ivy {
          borderchars = border,
        })
      end, { desc = "[S]earch by [G]rep" })

      vim.keymap.set("n", "<leader>sd", function()
        pickers.diagnostics(themes.get_ivy {
          previewer = false,
          borderchars = border,
        })
      end, { desc = "[S]earch [D]iagnostics" })

      vim.keymap.set("n", "<leader>d", function()
        require('dict').lookup()
      end, { desc = "[D]ictionary Lookup" })
    end
  end
}
