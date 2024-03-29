-- Pywal Color Scheme
return {
  'oncomouse/lushwal.nvim',
  name = "lushwal.nvim",
  cmd = { "LushwalCompile" }, -- Specify command to recompile wal colors
  event = "VeryLazy",
  dependencies = {
    -- Lush colorscheming engine
    { 'rktjmp/lush.nvim' },
    -- Shipwright (unused)
    -- { 'rktjmp/shipwright.nvim' },
  },
  init = function()
    local lush = require("lush")
    local lushwal = require("lushwal.base")
    local get_colors = require("lushwal.colors")

    vim.g.lushwal_configuration = {
      compile_to_vimscript = false, -- if we don't compile we don't need shipwright
      color_overrides = function(c)
        local overrides = { -- we don't want colors that aren't from pywal
          grey = c.color8.mix(c.color7, 30),      -- Darker mid-grey
          br_grey = c.color8.mix(c.color7, 65),   -- Mid-grey
          orange = c.color1,
          purple = c.color4,                      -- Purple
          pink = c.color4,                        -- Pink
          amaranth = c.color1,
          brown = c.color1,                       -- Brown
        }
        return vim.tbl_extend("force", c, overrides)
      end,
      addons = {
        gitsigns_nvim = true,
        indent_blankline_nvim = true,
        lualine = false,
        markdown = true,
        native_lsp = true,
        neogit = true,
        nvim_cmp = true,
        telescope_nvim = true,
        treesitter = true,
        which_key_nvim = true,
      },
    }

    local colors = get_colors()
    if colors ~= nil then
      vim.g.terminal_color_0 = colors.color0
      vim.g.terminal_color_1 = colors.color1
      vim.g.terminal_color_2 = colors.color2
      vim.g.terminal_color_3 = colors.color3
      vim.g.terminal_color_4 = colors.color4
      vim.g.terminal_color_5 = colors.color5
      vim.g.terminal_color_6 = colors.color6
      vim.g.terminal_color_7 = colors.color7
      vim.g.terminal_color_8 = colors.color8
      vim.g.terminal_color_9 = colors.color9
      vim.g.terminal_color_10 = colors.color10
      vim.g.terminal_color_11 = colors.color11
      vim.g.terminal_color_12 = colors.color12
      vim.g.terminal_color_13 = colors.color13
      vim.g.terminal_color_14 = colors.color14
      vim.g.terminal_color_15 = colors.color15

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

            -- Identifier { },
            -- Function { },

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
            -- Macro { },
            -- PreCondit { },

            Type { gui = "italic" },
            -- StorageClass { },
            Structure { fg = colors.color10, bg = colors.background, gui = "italic" },
            -- Typedef { },

            Special { gui = "bold" },
            SpecialComment { Comment, gui = "NONE" },

            -- Lazy
            LazyH1({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
            LazyH2({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
            LazyComment({ fg = colors.color3, bg = colors.background, gui = "italic" }),
            LazyNormal({ fg = colors.foreground, bg = colors.background }),
            Commit({ fg = colors.color1, bg = colors.background }),
            LazyCommitIssue({ fg = colors.color1, bg = colors.background, gui = "italic" }),
            LazyCommitType({ fg = colors.color9, bg = colors.background }),
            LazyCommitScope({ fg = colors.color9, bg = colors.background, gui = "italic" }),
            LazyDimmed({ fg = colors.color7, bg = colors.background }),
            LazyProp({ fg = colors.color2, bg = colors.background }),
            LazyValue({ fg = colors.color3, bg = colors.background }),
            LazyNoCond({ fg = colors.color4, bg = colors.background }),
            LazyLocal({ fg = colors.color5, bg = colors.background }),
            LazyProgressDone({ fg = colors.color8, bg = colors.background }),
            LazyProgressTodo({ fg = colors.color7, bg = colors.background }),
            LazySpecial({ fg = lushwal.Type.fg, bg = colors.background }),
            LazyReasonRuntime({ fg = colors.color7, bg = colors.background }),
            LazyReasonPlugin({ fg = colors.color7, bg = colors.background, gui = "italic" }),
            LazyReasonEvent({ fg = colors.color7, bg = colors.background, gui = "italic" }),
            LazyReasonKeys({ fg = colors.color7, bg = colors.background }),
            LazyReasonStart({ fg = colors.color7, bg = colors.background, gui = "bold" }),
            LazyReasonSource({ fg = colors.colory, bg = colors.background, gui = "bold" }),
            LazyReasonFt({ fg = colors.color7, bg = colors.background }),
            LazyReasonCmd({ fg = colors.color7, bg = colors.background }),
            LazyReasonImport({ fg = colors.color7, bg = colors.background, gui = "italic" }),
            LazyReasonRequire({ fg = colors.color7, bg = colors.background, gui = "italic" }),
            LazyButton({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
            LazyButtonActive({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
            LazyTaskOutput({ fg = colors.foreground, bg = colors.background }),
            LazyTaskError({ fg = colors.color1, bg = colors.background }),
            LazyDir({ fg = colors.color4, bg = colors.background }),
            LazyUrl({ fg = colors.color5, bg = colors.background }),

            -- Mason
            MasonNormal({ fg = colors.color1, bg = colors.background }),
            MasonHeader({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
            MasonHeaderSecondary({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
            MasonHighlight({ fg = colors.color3, bg = colors.background }),
            MasonHighlightBlock({ fg = colors.color3, bg = colors.color8 }),
            MasonHighlightBlockBold({ fg = colors.color3, bg = colors.color8, gui = "bold" }),
            MasonHighlightSecondary({ fg = colors.color2, bg = colors.background }),
            MasonHighlightBlockSecondary({ fg = colors.color2, bg = colors.color7 }),
            MasonHighlightBlockBoldSecondary({ fg = colors.color2, bg = colors.color7, gui = "bold" }),
            MasonLink({ fg = colors.color5, bg = colors.background }),
            MasonMuted({ fg = colors.color7, bg = colors.background }),
            MasonMutedBlock({ fg = colors.color7, bg = colors.background }),
            MasonMutedBlockBold({ fg = colors.color7, bg = colors.background, gui = "bold" }),
            MasonError({ fg = colors.background, bg = colors.foreground, gui = "bold" }),
            MasonWarning({ fg = colors.background, bg = colors.foreground, gui = "bold" }),
            MasonHeading({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
            ---@diagnostic enable undefined_global
          }
        end)

      -- then pass the extended spec to lush for application
      lush(spec)
    end

  end
}
