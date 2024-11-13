local util = require('util')

-- Fuzzy Finder (files, lsp, etc)
return {
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
      end,vim.api.nvim_get_current_buf(), "[?] Find recently opened files" )

      util.nmap("<leader><space>", function()
        pickers.buffers(themes.get_ivy {
          borderchars = border,
        })
      end,vim.api.nvim_get_current_buf(), "[ ] Find existing buffers" )

      util.nmap("<leader>/", function()
        pickers.current_buffer_fuzzy_find(themes.get_cursor {
          previewer = false,
          borderchars = border,
        })
      end,vim.api.nvim_get_current_buf(), "[/] Fuzzily search in current buffer" )

      util.nmap("<leader>gf", function()
        pickers.git_files(themes.get_ivy {
          borderchars = border,
        })
      end,vim.api.nvim_get_current_buf(), "Search [G]it [F]iles" )

      util.nmap("<leader>sf", function()
        pickers.find_files(themes.get_ivy {
          borderchars = border,
        })
      end,vim.api.nvim_get_current_buf(), "[S]earch [F]iles" )

      util.nmap("<leader>sh", function()
        pickers.help_tags(themes.get_ivy {
          borderchars = border,
        })
      end,vim.api.nvim_get_current_buf(), "[S]earch [H]elp" )

      util.nmap("<leader>sw", function()
        pickers.grep_string(themes.get_cursor {
          previewer = false,
          borderchars = border,
        })
      end,vim.api.nvim_get_current_buf(), "[S]earch current [W]ord" )

      util.nmap("<leader>sg", function()
        pickers.live_grep(themes.get_ivy {
          borderchars = border,
        })
      end,vim.api.nvim_get_current_buf(), "[S]earch by [G]rep" )

      util.nmap("<leader>sd", function()
        pickers.diagnostics(themes.get_ivy {
          previewer = false,
          borderchars = border,
        })
      end,vim.api.nvim_get_current_buf(), "[S]earch [D]iagnostics" )

      util.nmap("<leader>k", function()
        require('dict').lookup()
      end,vim.api.nvim_get_current_buf(), "Dictionary Loo[k]up" )
    end
  end
}
