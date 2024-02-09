local colorscheme_name = "walbones"
vim.g.colorscheme_name = colorscheme_name -- Required when defining a colorscheme

local lush = require "lush"
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require "zenbones.util"
local generate_colors = require "lushwal.colors"

local bg = vim.o.background

-- Lushwal configuration
vim.g.lushwal_configuration = {
	compile_to_vimscript = true,
	color_overrides = nil,
	addons = {
		gitsigns_nvim = true,
		indent_blankline_nvim = true,
		lualine = true,
		markdown = true,
		mini_nvim = true,
		native_lsp = true,
		nvim_cmp = true,
		telescope_nvim = true,
		treesitter = true,
		which_key_nvim = true,
	}
}

-- Get colors from wal
local wal_colors = generate_colors()

-- Define a palette. Use `palette_extend` to fill unspecified colors
local palette
palette = util.palette_extend({
	bg = hsluv(tostring(wal_colors.background)),
	fg = hsluv(tostring(wal_colors.foreground)),
	rose = hsluv(tostring(wal_colors.red)),
	leaf = hsluv(tostring(wal_colors.green)),
	wood = hsluv(tostring(wal_colors.yellow)),
	water = hsluv(tostring(wal_colors.blue)),
	blossom = hsluv(tostring(wal_colors.magenta)),
	sky = hsluv(tostring(wal_colors.cyan)),
	bg1 = hsluv(tostring(wal_colors.background)),
	fg1 = hsluv(tostring(wal_colors.foreground)),
	rose1 = hsluv(tostring(wal_colors.red)),
	leaf1 = hsluv(tostring(wal_colors.green)),
	wood1 = hsluv(tostring(wal_colors.brown)),
	water1 = hsluv(tostring(wal_colors.blue)),
	blossom1 = hsluv(tostring(wal_colors.magenta)),
	sky1 = hsluv(tostring(wal_colors.cyan)),
}, bg)

-- Generate the lush specs using the generator util
local generator = require("zenbones.specs")
local specs = generator.generate(palette, bg, generator.get_global_config(colorscheme_name, bg))

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)
