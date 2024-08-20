-- Highlight, edit, and navigate code
return {
  "nvim-treesitter/nvim-treesitter",
  name = "nvim-treesitter",
  -- lazy = false,
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-refactor",
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = {
        enable = true,           -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 1,           -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 1, -- Maximum number of lines to show for a single context
        trim_scope = 'outer',    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',         -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    },
  },
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      sync_install = true,
      modules = {},
      ignore_install = {},

      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = { "bash", "bibtex", "c", "clojure", "comment", "cpp", "csv", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "gpg", "ini", "json", "julia", "latex", "lua", "make", "markdown_inline", "matlab", "perl", "psv", "python", "pymanifest", "readline", "requirements", "ssh_config", "tsv", "typst", "query", "yaml", "tmux", "toml", "vimdoc", "vim", "xml", "zathurarc" },

      -- Autoinstall languages that are not installed. Defaults to false
      auto_install = true,
      highlight = {
        enable = true,
        disable = { "latex", "tex" },
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<M-space>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    })
  end,
  init = function()
    vim.treesitter.language.register("latex", "tex")
    vim.treesitter.language.register("tex", "latex")
  end,
}
