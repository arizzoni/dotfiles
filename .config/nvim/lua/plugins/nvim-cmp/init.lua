-- Autocompletion
return {
  "hrsh7th/nvim-cmp",
  name = "nvim-cmp",
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    "L3MON4D3/LuaSnip",                     -- Snippet Engine
    "saadparwaiz1/cmp_luasnip",             -- Luasnip source
    -- Adds LSP completion capabilities
    "hrsh7th/cmp-nvim-lsp",                 -- LSP completion
    "hrsh7th/cmp-nvim-lsp-document-symbol", -- LSP completion
    "hrsh7th/cmp-nvim-lsp-signature-help",  -- LSP completion
    "hrsh7th/cmp-buffer",                   -- Buffer completion
    "hrsh7th/cmp-path",                     -- Completion for paths
    "hrsh7th/cmp-cmdline",                  -- Completion for command line
    "hrsh7th/cmp-nvim-lua",                 -- Neovim Lua completion source
    "rcarriga/cmp-dap",                     -- DAP completion source
    "micangl/cmp-vimtex",                   -- Vimtex completion source
    "ray-x/cmp-treesitter",                 -- Treesitter Autocompletion
    "petertriho/cmp-git",                   -- Adds git autocompletion
    "lukas-reineke/cmp-rg",                 -- Ripgrep autocompletion
    "kdheepak/cmp-latex-symbols",           -- LaTeX symbol autocompletion
    "windwp/nvim-autopairs",                -- Autopairs completion
  },
  opts = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup {}
    return {
      view = {
        entries = "custom"
      },
      window = {
        completion = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = -3,
          side_padding = 0,
        },
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, vim_item)
          vim_item.menu = string.format('(%s)', vim_item.kind)
          -- vim_item.kind = string.format(' %s ', kind_icons[vim_item.kind])
          return vim_item
        end
      },
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
        ["<C-Tab>"] = cmp.mapping.confirm {
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
        { name = "cmp-vimtex" },
        { name = "nvim_lua" },
        { name = "nvim_lsp_document_symbol" },
        { name = "nvim_lsp_signature_help" },
        { name = "path" },
        { name = "dap" },
        { name = "cmdline" },
        { name = "treesitter" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "git" },
        { name = "latex_symbols" },
        { name = "rg" },
        { name = "otter" },
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
  end,
  init = function()
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end
}
