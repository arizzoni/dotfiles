-- First we will need lush, and the colorscheme we wish to modify
local lush = require("lush")
local lushwal = require("lushwal.base")

vim.o.background = "dark"
vim.g.colorscheme_name = "patched-lushwal"

-- we can apply modifications ontop of the existing colorscheme
local spec = lush.extends({ lushwal }).with(function()
  return {
    Boolean({ fg = lushwal.Boolean.fg, lushwal.Boolean.bg, gui = "italic" }),
    Conditional({ fg = lushwal.Conditional.fg, lushwal.Conditional.bg, gui = "bold" }),
    Define({ fg = lushwal.Define.fg, lushwal.Define.bg, gui = "bold" }),
    Include({ fg = lushwal.Include.fg, lushwal.Include.bg, gui = "bold" }),
    Keyword({ fg = lushwal.Keyword.fg, lushwal.Keyword.bg, gui = "bold" }),
    Type({ fg = lushwal.Type.fg, lushwal.Type.bg, gui = "italic" }),
  }
end)

-- then pass the extended spec to lush for application
lush(spec)

-- vim: tabstop=2 shiftwidth=2 expandtab
