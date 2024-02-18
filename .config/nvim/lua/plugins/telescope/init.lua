-- Fuzzy Finder (files, lsp, etc)
return {
  "nvim-telescope/telescope.nvim",
  name = "telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "nvim-telescope/telescope-dap.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "tsakirist/telescope-lazy.nvim",
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-d>"] = false,
        },
      },
    },
    -- extensions = {
    --   ["ui-select"] = {
    --     require("telescope").themes.get_cursor({})
    --   },
    -- },
  },
  init = function()
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("dap")
    require("telescope").load_extension("ui-select")

    --[[ Telescope Keymaps ]]
    local pickers = require("telescope.builtin")
    local themes = require("telescope.themes")

    if pickers ~= nil and themes ~= nil then

      vim.keymap.set("n", "<leader>?", function()
        pickers.oldfiles(themes.get_ivy {
          winblend = 10,
        })
      end, { desc = "[?] Find recently opened files" })

      vim.keymap.set("n", "<leader><space>", function()
        pickers.buffers(themes.get_ivy {
          winblend = 10,
        })
      end, { desc = "[ ] Find existing buffers" })

      vim.keymap.set("n", "<leader>/", function()
        pickers.current_buffer_fuzzy_find(themes.get_ivy {
          winblend = 10,
          previewer = false,
        })
      end, { desc = "[/] Fuzzily search in current buffer" })

      vim.keymap.set("n", "<leader>gf", function()
        pickers.git_files(themes.get_ivy {
          winblend = 10,
        })
      end, { desc = "Search [G]it [F]iles" })

      vim.keymap.set("n", "<leader>sf", function()
        pickers.find_files(themes.get_ivy {
          winblend = 10,
        })
      end, { desc = "[S]earch [F]iles" })

      vim.keymap.set("n", "<leader>sh", function()
        pickers.help_tags(themes.get_ivy {
          winblend = 10,
        })
      end, { desc = "[S]earch [H]elp" })

      vim.keymap.set("n", "<leader>sw", function()
        pickers.grep_string(themes.get_cursor {
          winblend = 10,
          previewer = false,
        })
      end, { desc = "[S]earch current [W]ord" })

      vim.keymap.set("n", "<leader>sg", function()
        pickers.live_grep(themes.get_ivy {
          winblend = 10,
        })
      end, { desc = "[S]earch by [G]rep" })

      vim.keymap.set("n", "<leader>sd", function()
        pickers.diagnostics(themes.get_ivy {
          winblend = 10,
        })
      end, { desc = "[S]earch [D]iagnostics" })
    end
  end
}
