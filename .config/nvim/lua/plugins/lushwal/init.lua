-- Pywal Color Scheme
return {
  -- 'oncomouse/lushwal.nvim',
  dir = "/home/air/projects/lushwal.nvim/",
  name = "lushwal.nvim",
  cmd = { "LushwalCompile" }, -- Specify command to recompile wal colors
  lazy = false,
  enabled = false,
  dependencies = {
    -- Lush colorscheming engine
    { 'rktjmp/lush.nvim' },
    -- Shipwright
    { 'rktjmp/shipwright.nvim' },
  },
  init = function()
    vim.g.lushwal_configuration = {
      compile_to_vimscript = true,
      terminal_colors = true,
      color_overrides = function(colors)
        local overrides = { -- we don't want colors that aren't from pywal
          grey = colors.color7,
          br_grey = colors.color15,
          orange = colors.color1,
          purple = colors.color4,
          pink = colors.color4,
          amaranth = colors.color1,
          brown = colors.color1,
        }
        return vim.tbl_extend("force", colors, overrides)
      end,
      addons = {
        gitsigns_nvim = true,
        indent_blankline_nvim = true,
        markdown = true,
        native_lsp = true,
        nvim_cmp = true,
        telescope_nvim = true,
        treesitter = true,
        which_key_nvim = true,
      },
      lush_overrides = function()
        return {
          ---@diagnostic disable undefined_global
          Underlined({ gui = "underline" }),
          Bold({ gui = "bold" }),
          Italic({ gui = "italic" }),
          Comment({ gui = "italic" }),
          CursorLineNr({ gui = "bold" }),
          SpellRare({ gui = "underline" }),
          String({ gui = "italic" }),
          Character({ gui = "italic" }),
          -- Number({ fg = scheme.color4 }),
          Boolean({ gui = "italic" }),
          Float({ Number }),
          Statement({ gui = "bold" }),
          Conditional({ gui = "bold" }),
          Repeat({ gui = "bold" }),
          Label({ gui = "bold" }),
          Operator({ gui = "bold" }),
          Keyword({ gui = "bold" }),
          Exception({ gui = "bold" }),
          PreProc({ gui = "bold" }),
          Include({ gui = "bold" }),
          Define({ gui = "bold" }),
          Type({ gui = "italic" }),
          Structure({ gui = "italic" }),
          Special({ gui = "bold" }),
          SpecialComment({ gui = "NONE" }),

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

          -- UI Borders
          -- FloatBorder({ fg = scheme.color8, bg = scheme.background }),
          WhichKeyBorder({ FloatBorder }),
          TelescopeBorder({ FloatBorder }),

          -- ColorColumn({ fg = scheme.color1, bg = scheme.color1 }),
          ---@diagnostic enable undefined_global
        }
      end,
    }
  end
}
