-- Pywal Color Scheme
return {
  -- 'oncomouse/lushwal.nvim',
  dir = "/home/air/projects/lushwal.nvim/",
  name = "lushwal.nvim",
  cmd = { "LushwalCompile" }, -- Specify command to recompile wal colors
  event = "VeryLazy",
  dependencies = {
    -- Lush colorscheming engine
    { 'rktjmp/lush.nvim' },
    -- Shipwright
    { 'rktjmp/shipwright.nvim' },
  },
  config = function()
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
      lush_overrides = function(colors)
        return {
          ---@diagnostic disable undefined_global
          Comment({ gui = "italic" }),
          CursorLineNr({ gui = "bold" }),
          SpellRare({ fg = colors.color14, bg = colors.background, gui = "underline" }),
          String({ gui = "italic" }),
          Character({ gui = "italic" }),
          Number({ fg = colors.color4 }),
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
          Define({ fg = colors.color2, bg = colors.background, gui = "bold" }),
          Type({ gui = "italic" }),
          Structure({ fg = colors.color10, bg = colors.background, gui = "italic" }),
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
          FloatBorder({ fg = colors.color8, bg = colors.background }),
          WhichKeyBorder({ FloatBorder }),
          TelescopeBorder({ FloatBorder }),
          ---@diagnostic enable undefined_global
        }
      end,
    }
  end
}
