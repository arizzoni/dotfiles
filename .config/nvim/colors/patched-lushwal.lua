-- First we will need lush, and the colorscheme we wish to modify
local lush = require("lush")
local lushwal = require("lushwal.base")
local get_colors = require("lushwal.colors")

vim.o.background = "dark"
vim.g.colorscheme_name = "patched-lushwal"

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
  local spec = lush.extends({ lushwal }).with(function()
    return {
      Boolean({ fg = lushwal.Boolean.fg, bg = lushwal.Boolean.bg, gui = "italic" }),
      Conditional({ fg = lushwal.Conditional.fg, bg = lushwal.Conditional.bg, gui = "bold" }),
      Define({ fg = lushwal.Define.fg, bg = lushwal.Define.bg, gui = "bold" }),
      Include({ fg = lushwal.Include.fg, bg = lushwal.Include.bg, gui = "bold" }),
      Keyword({ fg = lushwal.Keyword.fg, bg = lushwal.Keyword.bg, gui = "bold" }),
      Type({ fg = lushwal.Type.fg, bg = lushwal.Type.bg, gui = "italic" }),

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
      MasonMutedBlock({ fg = colors.color7, bg = colors.background}),
      MasonMutedBlockBold({ fg = colors.color7, bg = colors.background, gui = "bold"}),
      MasonError({ fg = colors.background, bg = colors.foreground, gui = "bold" }),
      MasonWarning({ fg = colors.background, bg = colors.foreground, gui = "bold" }),
      MasonHeading({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
      }
  end)

  -- then pass the extended spec to lush for application
  lush(spec)
end
