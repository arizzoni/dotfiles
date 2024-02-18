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

      LazyReasonSource({ fg = colors.color7, bg = lushwal.Boolean.bg, gui = "italic" }),
      LazyH1({ fg = colors.foreground, bg = lushwal.Boolean.bg, gui = "bold" }),
      LazyNormal({ fg = colors.foreground, bg = colors.background }),
      LazyButton({ fg = colors.foreground, bg = lushwal.Type.bg, gui = "bold" }),
      LazyButtonActive({ fg = colors.foreground, bg = colors.background, gui = "bold" }),
      LazySpecial({ fg = lushwal.Type.fg, bg = lushwal.Type.bg}),
      LazyH2({ fg = colors.foreground, bg = lushwal.Type.bg, gui = "bold" }),
    }
  end)

  -- then pass the extended spec to lush for application
  lush(spec)
end
