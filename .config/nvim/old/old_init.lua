-- /.config/nvim/init.lua

---@diagnostic disable-next-line undefined-global
local vim = vim

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable the builtin filetype plugin
-- vim.bo.filetype = true
vim.g.do_filetype_lua = true

-- Install package manager
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

-- Setup packages
require("lazy").setup({

  --{{{ Editor
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- -- "gc" to comment visual regions/lines, etc.
  -- {
  --   "numToStr/Comment.nvim",
  --   opts = {},
  --   lazy = false,
  -- },
  { import = "modules.comment" },

  -- Show pending keybinds
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.timeout = true
      vim.opt.timeoutlen = 300
    end,
    opts = {}
  },

  -- Tagged To-Do comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        FIX  = { icon = "󰅗", color = "error", alt = { "BUG" } },
        TODO = { icon = "󰄲", color = "info", alt = { "DONE" } },
        HACK = { icon = "󰅨", color = "warning", alt = { "REFACTOR" } },
        WARN = { icon = "󰀧", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󰒔", color = "default", alt = { "OPT", "PERF", "OPTIMIZE", "PERFORMANCE" } },
        NOTE = { icon = "󰏬", color = "hint", alt = { "HINT", "REF", "INFO" } },
        TEST = { icon = "󰅫", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg" },
        warning = { "DiagnosticWarn", "WarningMsg" },
        info = { "DiagnosticInfo" },
        hint = { "DiagnosticHint" },
        default = { "Identifier" },
        test = { "Identifier" },
      },
      highlight = {
        multiline = false,
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      debounce = 100,
      indent = { char = "░" },
      whitespace = { remove_blankline_trail = true },
      scope = {
        show_start = true,
        show_end = true,
        show_exact_scope = true,
        highlight = { "Function" },
      },
    }
  },

  -- Set lualine as statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        theme = "auto",
        globalstatus = true,
        component_separators = "|",
        section_separators = ""
      },
      tabline = {
        lualine_a = {
          {
            "buffers",
            mode = 1,
            path = 3,
            use_mode_colors = true,
          }
        },
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "branch" }
      },
      extensions = {
        "fugitive",
        "fzf",
        "lazy",
        "man",
        "mason",
      },

    },
  },
  --}}}

  --{{{ Colorscheme Packages

  -- Correct transparency
  {
    "xiyaowong/transparent.nvim",
    opts = {},
    lazy = false,
  },

  -- Zenbones color scheme
  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },

  -- Pywal Color Scheme
  {
    "oncomouse/lushwal.nvim",
    -- dir = "~/Projects/lushwal.nvim/",
    cmd = { "LushwalCompile" }, -- Specify command to recompile wal colors
    dependencies = {
      -- Lush colorscheming engine
      { "rktjmp/lush.nvim" },
      -- Shipwright
      { "rktjmp/shipwright.nvim" },
    },

  },

  --}}}

  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      -- Useful status updates for LSP
      { "j-hui/fidget.nvim",       tag = "legacy", event = "LspAttach", opts = {} },
      -- Additional lua configuration
      { "folke/neodev.nvim",       opts = {} },
    },
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      "L3MON4D3/LuaSnip",         -- Snippet Engine
      "saadparwaiz1/cmp_luasnip", -- Luasnip source
      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",     -- LSP completion
      "hrsh7th/cmp-buffer",       -- Buffer completion
      "hrsh7th/cmp-path",         -- Completion for paths
      "hrsh7th/cmp-cmdline",      -- Completion for command line
      "hrsh7th/cmp-nvim-lua",     -- Neovim Lua completion source
      "ray-x/cmp-treesitter",     -- Treesitter Autocompletion
      "petertriho/cmp-git",       -- Adds git autocompletion
      "lukas-reineke/cmp-rg",     -- Ripgrep autocompletion
    },
  },

  --{{{ Git related plugins
  "tpope/vim-fugitive", -- Git command line tools for Neovim
  "tpope/vim-rhubarb",  -- Completions for usernames in shared repos

  -- Adds git releated signs to the gutter, as well as utilities for managing changes
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "–" },
        topdelete = { text = "=" },
        changedelete = { text = "≃" },
        untracked = { text = "×" }
      },
      on_attach = function(bufnr)
        vim.keymap.set("n", "[c", require("gitsigns").prev_hunk, { buffer = bufnr, desc = "Go to Previous Hunk" })
        vim.keymap.set("n", "]c", require("gitsigns").next_hunk, { buffer = bufnr, desc = "Go to Next Hunk" })
        vim.keymap.set("n", "<leader>ph", require("gitsigns").preview_hunk,
          { buffer = bufnr, desc = "[P]review [H]unk" })
      end,
    },
  },
  --}}}

  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "tsakirist/telescope-lazy.nvim",
    },
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available.

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable "make" == 1
    end,
  },

  -- Email with Himalaya
  {
    url = "https://git.sr.ht/~soywod/himalaya-vim"
  },

  -- Highlight, edit, and navigate code
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    build = ":TSUpdate",
  },

  {
    "lervag/vimtex",
    lazy = false,
  },
})

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

require("mason").setup()

-- Enable the following language servers
-- Add any additional override configuration in the following tables.
-- They will be passed to the `settings` field of the server config.
local servers = {
  bashls = {
    bashls = {
      name = "bash-language-server",
      cmd = { "bash-language-server", "start" },
    },
  },
  clangd = {
    clangd = {
      cmd = { "clangd" },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
      single_file_support = { "true" },
    },
  },
  cmake = {},
  texlab = {
    texlab = {
      cmd = { "texlab" },
    },
  },
  julials = {}, -- TODO: set up compiled lsp
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  matlab_ls = {},
  pylsp = {
    pylsp = {
      plugins = {
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        pylsp_mypy = { enabled = true },
        jedi_completion = { fuzzy = true },
        pyls_isort = { enabled = true },
      },
    },
  },
}

-- nvim-cmp supports additional completion capabilities,
-- so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {

  function(server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- [[ Configure nvim-cmp ]]
local cmp = require "cmp"
local luasnip = require "luasnip"
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    -- ["<C-Space>"] = cmp.mapping.complete {},
    ["<Tab>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<C-Space>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "git" },
    { name = "latex_symbols" },
    { name = "rg" },
  },
  enabled = function()
    local context = require("cmp.config.context")
    if vim.api.nvim_get_mode().mode == "c" then
      return true
    else
      return not context.in_treesitter_capture("comment")
          and not context.in_syntax_group("Comment")
    end
  end
}

-- [[ Basic Keymaps ]]

-- Disable arrow keys
vim.keymap.set({ "n", "v", "i" }, "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<Right>", "<Nop>", { noremap = true, silent = true })

-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local telescope = require("telescope")
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup {
  sync_install = true,
  modules = {},
  ignore_install = {},

  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { "bash", "c", "cpp", "csv", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
    "gpg", "ini", "julia", "lua", "make", "markdown_inline", "matlab", "psv", "python", "json", "ssh_config", "tsv",
    "yaml", "toml", "vimdoc", "vim", "xml" },

  -- Autoinstall languages that are not installed. Defaults to false
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
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
}

-- [[ Diagnostic keymaps ]]
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Vimtex ]]
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_latexmk = {
  options = {
    "-verbose",
    "-file-line-error",
    "-synctex=1",
    "-interaction=nonstopmode",
    "-shell-escape",
    "-f",
    "-g",
  },
}

-- [[ Settings ]]
vim.opt.shortmess = "I" -- Disable short message (start screen)
vim.opt.scrolloff = 4
vim.opt.undofile = true
vim.opt.wrap = true
vim.opt.writebackup = true
vim.opt.hlsearch = true    -- Set highlight on search
vim.opt.number = true      -- Make relative line numbers default
vim.opt.relativenumber = true
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true    -- Save undo history
vim.opt.ignorecase = true  -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.updatetime = 250   -- Decrease update time
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.completeopt = "menuone,noselect"                                    -- Set completeopt to have a better completion experience
vim.opt.termguicolors = true                                                -- Make sure the terminal supports this
vim.opt.number = true                                                       -- Line numbers
vim.opt.expandtab = true                                                    -- Expand tabs to spaces
vim.opt.modeline = true                                                     -- Enable modeline
vim.g.python3_host_prog = "/home/air/.local/share/python/neovim/bin/python" -- Python executable
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- [[ Netrw Settings ]]
vim.g.netrw_browse_split = 4
vim.g.netrw_fastbrowse = 0
vim.g.netrw_sort_by = "exten"
vim.g.netrw_mousemaps = 0
vim.g.netrw_winsize = 18
vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 1                                      -- Keep the current directory and the browsing directory synced.
vim.g.netrw_sort_sequence = [[[\/]$,*]]                      -- Show directories first (sorting)
vim.g.netrw_sizestyle = "H"                                  -- Human-readable files size
vim.g.netrw_liststyle = 3                                    -- tree style listing
vim.g.netrw_list_hide = vim.fn["netrw_gitignore#Hide"]()     -- Patterns for hiding files, e.g. node_modules
vim.g.netrw_hide = 0                                         -- show all files
vim.g.netrw_preview = 1                                      -- Preview files in a vertical split window
vim.g.netrw_localcopydircmd = "cp -r"                        -- Enable recursive copy of directories in *nix systems
vim.g.netrw_localmkdir = "mkdir -p"                          -- Enable recursive creation of directories in *nix systems
vim.g.netrw_localrmdir = "rm -r"                             -- Enable recursive removal of directories in *nix systems
vim.api.nvim_set_hl(0, "netrwMarkFile", { link = "Search" }) -- Highlight marked files in the same way search matches are

-- [[ Terminal Settings ]]
-- TODO: get colored prompt working in neovide
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd("startinsert")
      vim.o.number = false
      vim.o.relativenumber = false
    end
  end
})

vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    vim.cmd("bdelete")
  end
})

-- [[ Neovide Settings ]]
if vim.g.neovide then
  vim.g.neovide_transparency = 0.8
  vim.g.neovide_background_color = "#000000"
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_cursor_animation_length = 0.125
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_vfx_mode = ""
  vim.cmd("Vexplore")
end

-- [[ Theming Settings ]]
vim.g.transparent_enabled = true
vim.cmd.colorscheme("patched-lushwal")
