-- Autocompletion
return {
  "hrsh7th/nvim-cmp",
  name = "nvim-cmp",
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
  opts = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup {}

    return {
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
  end
}
