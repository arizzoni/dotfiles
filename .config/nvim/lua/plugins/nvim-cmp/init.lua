-- Autocompletion
return {
  "hrsh7th/nvim-cmp",
  name = "nvim-cmp",
  event = "VeryLazy",
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
    "micangl/cmp-vimtex",                   -- Vimtex completion source
    "windwp/nvim-autopairs",                -- Autopairs completion
  },
  opts = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup {}
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    }
    )
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' }
          }
        }
      })
    })
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
        -- ["<C-n>"] = cmp.mapping.select_next_item(),
        -- ["<C-p>"] = cmp.mapping.select_prev_item(),
        -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete {},
        ["<Tab>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
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
        { name = "luasnip", keyword_length = 2 },
        { name = "nvim_lsp", keyword_length = 2 },
        { name = "nvim_lsp_document_symbol", keyword_length = 2 },
        { name = "nvim_lsp_signature_help", keyword_length = 2 },
        { name = "buffer", keyword_length = 2 },
        { name = "path", keyword_length = 2 },
        { name = "cmdline", keyword_length = 2 },
        { name = "nvim_lua", keyword_length = 2 },
        { name = "cmp-vimtex", keyword_length = 2 },
        { name = "autopairs", keyword_length = 2 },
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
}
