-- Pywal Color Scheme
return {
  'oncomouse/lushwal.nvim',
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
    vim.g.lushwal_configuration = {
      compile_to_vimscript = false,             -- if we don't compile we don't need shipwright
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
    local lush = require("lush")
    local convert = require("lush.vivid.hsl.convert")
    local lushwal = require("lushwal.base")
    local get_colors = require("lushwal.colors")
    local colors = get_colors()

    if colors ~= nil then
      -- Set terminal colors
      vim.g.terminal_color_0 = convert.hsl_to_hex(colors.color0)
      vim.g.terminal_color_1 = convert.hsl_to_hex(colors.color1)
      vim.g.terminal_color_2 = convert.hsl_to_hex(colors.color2)
      vim.g.terminal_color_3 = convert.hsl_to_hex(colors.color3)
      vim.g.terminal_color_4 = convert.hsl_to_hex(colors.color4)
      vim.g.terminal_color_5 = convert.hsl_to_hex(colors.color5)
      vim.g.terminal_color_6 = convert.hsl_to_hex(colors.color6)
      vim.g.terminal_color_7 = convert.hsl_to_hex(colors.color7)
      vim.g.terminal_color_8 = convert.hsl_to_hex(colors.color8)
      vim.g.terminal_color_9 = convert.hsl_to_hex(colors.color9)
      vim.g.terminal_color_10 = convert.hsl_to_hex(colors.color10)
      vim.g.terminal_color_11 = convert.hsl_to_hex(colors.color11)
      vim.g.terminal_color_12 = convert.hsl_to_hex(colors.color12)
      vim.g.terminal_color_13 = convert.hsl_to_hex(colors.color13)
      vim.g.terminal_color_14 = convert.hsl_to_hex(colors.color14)
      vim.g.terminal_color_15 = convert.hsl_to_hex(colors.color15)

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

            -- Nvim-cmp
            PmenuSel = { bg = "#282C34", fg = "NONE" },
            Pmenu = { fg = "#C5CDD9", bg = "#22252A" },

            CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", strikethrough = true },
            CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", bold = true },
            CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", bold = true },
            CmpItemMenu = { fg = "#C792EA", bg = "NONE", italic = true },

            CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
            CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
            CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },

            CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
            CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
            CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },

            CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
            CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
            CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },

            CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
            CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
            CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
            CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
            CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },

            CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
            CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },

            CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
            CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
            CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },

            CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
            CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
            CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },

            CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
            CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
            CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },

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
  end
}
