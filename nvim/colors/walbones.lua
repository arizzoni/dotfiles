-- walbones.lua
-- lushwal + zenbones colorscheme for neovim
-- V0.2

-- Alessandro Rizzoni, 2023-10-02
-- All licences of dependencies apply. Where intersection occurs GPLv3 may be
-- given priority. All credit goes to the developers of the dependencies and 
-- of Neovim itself.

-- Setup colorscheme
local colorscheme_name = "walbones" -- i.e. :colo walbones
vim.g.colors_name = colorscheme_name -- Required when defining a colorscheme
local bg = vim.o.background -- Preserve background color

-- Imports
local lush = require("lush") -- Color and theming utilities
local generator = require("zenbones.specs") -- We want the zenbones highlighting
local term = require("zenbones.term") -- Optional Zenbones terminal styling
local lushwal = require("lushwal") -- Lush compatible wal colors
local generate_colors = require("lushwal.colors") -- Get wal colors from lushwal

-- Lushwal configuration
vim.g.lushwal_configuration = { -- Should this be in another place?
	compile_to_vimscript = false, -- Frequent changes make compiling wasteful
	color_overrides = nil,
	addons = { -- Turn on selected plugins
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

vim.api.nvim_command(":colo lushwal")

local function walbones()

	local colors = generate_colors() -- Get colors from wal

	-- Define a palette manually.
	colors.fg = colors.foreground
	colors.fg = colors.foreground
	colors.bg = colors.background
	colors.wood = colors.color1
	colors.leaf = colors.color2
	colors.water = colors.color3
	colors.rose = colors.color4
	colors.blossom = colors.color5
	colors.sky = colors.color6

	-- Extended palette colors
	colors.bg1 = colors.bg
	colors.bg_stark = colors.color0
	colors.bg_warm = colors.color8
	colors.rose1 = colors.color9
	colors.leaf1 = colors.color10
	colors.wood1 = colors.color11
	colors.water1 = colors.color12
	colors.blossom1 = colors.color13
	colors.sky1 = colors.color14
	colors.fg1 = colors.color15

	-- Generate the lush specs using the zenbones generator utility
	local specs = generator.generate( -- Import zenbones specs and generate the new specs for lush
	        colors, -- Apply wal colors to zenbones
	        bg, -- Preserve background color
	        generator.get_global_config(colorscheme_name, bg)
	        )

	-- Pass the specs to lush to apply
	lush(specs)

	-- Optionally set term colors
	term.apply_colors(colors)
end

walbones()

-- Set up the hook
lushwal.add_reload_hook(walbones)
