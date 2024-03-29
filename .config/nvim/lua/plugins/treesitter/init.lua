-- Highlight, edit, and navigate code
return {
  "nvim-treesitter/nvim-treesitter",
  name = "nvim-treesitter",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-refactor",
    "nvim-treesitter/nvim-treesitter-context",
  },
  build = ":TSUpdate",
  opts = {
    sync_install = true,
    modules = {},
    ignore_install = {},

    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "bash", "bibtex", "c", "clojure", "comment", "cpp", "csv", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "gpg", "ini", "json", "latex", "lua", "make", "markdown_inline", "perl", "pip_requirements", "psv", "python", "PyPA manifest", "readline", "ssh_config", "tsv", "query", "yaml", "tmux", "toml", "vimdoc", "vim", "xml", "zathurarc" },

    -- Autoinstall languages that are not installed. Defaults to false
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    indent = { enable = false },
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
  },
}
