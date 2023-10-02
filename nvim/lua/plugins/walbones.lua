local colors_name = "walbones"
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require "lush"
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require "zenbones.util"

local bg = vim.o.background

-- Define a palette. Use `palette_extend` to fill unspecified colors
local pywal16_core = require 'pywal16.core' -- pull colors from wal
local colors = pywal16_core.get_colors() -- put colors in dictionary
local palette = util.palette_extend(colors, bg) -- build palette

-- Generate the lush specs using the generator util
local generator = require "zenbones.specs"
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
        return {
                Statement { base_specs.Statement, fg = palette.color3 },
                Special { fg = palette.color4 },
                Type { fg = paletter.color5 },
        }
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)
