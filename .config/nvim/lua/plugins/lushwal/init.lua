-- Pywal Color Scheme
return {
  -- 'oncomouse/lushwal.nvim',
  'arizzoni/lushwal.nvim',
  branch = 'terminal_colors',
  name = "lushwal.nvim",
  cmd = { "LushwalCompile" }, -- Specify command to recompile wal colors
  event = "VeryLazy",
  dependencies = {
    -- Lush colorscheming engine
    { 'rktjmp/lush.nvim' },
    -- Shipwright
    -- { 'rktjmp/shipwright.nvim' },
  },
  config = function()
    local lush = require("lush")
    local lushwal = require("lushwal.base")
    local get_colors = require("lushwal.colors")
    local colors = get_colors()

    vim.g.lushwal_configuration = {
      compile_to_vimscript = false,             -- if we don't compile we don't need shipwright
      terminal_colors = true,
      color_overrides = function(c)
        local overrides = {                     -- we don't want colors that aren't from pywal
          grey = c.color8.mix(c.color7, 30),    -- Darker mid-grey
          br_grey = c.color8.mix(c.color7, 65), -- Mid-grey
          orange = c.color1,
          purple = c.color4,
          pink = c.color4,
          amaranth = c.color1,
          brown = c.color1,
        }
        return vim.tbl_extend("force", c, overrides)
      end,
      addons = {
        gitsigns_nvim = true,
        indent_blankline_nvim = true,
        markdown = true,
        native_lsp = true,
        neogit = true,
        nvim_cmp = true,
        telescope_nvim = true,
        treesitter = true,
        which_key_nvim = true,
      },
    }

    -- we can apply modifications ontop of the existing colorscheme
    local spec = lush.extends({ lushwal }).with(
      function()
        return {
          ---@diagnostic disable undefined_global
          Comment { gui = "italic" },
          CursorLineNr { gui = "bold" },
          SpellRare { fg = colors.color14, bg = colors.background, gui = "underline" },
          String { gui = "italic" },
          Character { gui = "italic" },
          Number { fg = colors.color4 },
          Boolean { gui = "italic" },
          Float { Number },
          Statement { gui = "bold" },
          Conditional { gui = "bold" },
          Repeat { gui = "bold" },
          Label { gui = "bold" },
          Operator { gui = "bold" },
          Keyword { gui = "bold" },
          Exception { gui = "bold" },
          PreProc { gui = "bold" },
          Include { gui = "bold" },
          Define { fg = colors.color2, bg = colors.background, gui = "bold" },
          Type { gui = "italic" },
          Structure { fg = colors.color10, bg = colors.background, gui = "italic" },
          Special { gui = "bold" },
          SpecialComment { Comment, gui = "NONE" },

          -- Lazy
          LazyH1({ gui = "bold" }),
          LazyH2({ gui = "bold" }),
          LazyComment({ gui = "italic" }),
          LazyCommitIssue({ gui = "italic" }),
          LazyCommitScope({ gui = "italic" }),
          LazyReasonPlugin({ gui = "italic" }),
          LazyReasonEvent({ gui = "italic" }),
          LazyReasonStart({ gui = "bold" }),
          LazyReasonSource({ gui = "bold" }),
          LazyReasonImport({ gui = "italic" }),
          LazyReasonRequire({ gui = "italic" }),
          LazyButton({ gui = "bold" }),
          LazyButtonActive({ gui = "bold" }),

          -- Mason
          MasonHeader({ gui = "bold" }),
          MasonHeaderSecondary({ gui = "bold" }),
          MasonHighlightBlockBold({ gui = "bold" }),
          MasonHighlightBlockBoldSecondary({ gui = "bold" }),
          MasonMutedBlockBold({ gui = "bold" }),
          MasonError({ gui = "bold" }),
          MasonWarning({ gui = "bold" }),
          MasonHeading({ gui = "bold" }),

          -- Vim Illuminate
          IlluminatedWordText = { gui = "bold" },
          IlluminatedWordRead = { gui = "bold" },
          IlluminatedWordWrite = { gui = "bold" },
          ---@diagnostic enable undefined_global
        }
      end)

    -- then pass the extended spec to lush for application
    lush(spec)
  end
}
