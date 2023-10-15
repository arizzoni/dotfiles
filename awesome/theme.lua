-- theme.lua - Theme for AwesomeWM
-- Alessandro Rizzoni

local awful = require("awful")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local function scan_dir(directory)
	local i, fileList, popen = 0, {}, io.popen
	for filename in popen([[find "]] ..directory.. [[" -type f]]):lines() do
	    i = i + 1
	    fileList[i] = filename
	end
	return fileList
    end

math.randomseed(os.time())

local theme = {}
-- Change wallpaper and get colors from Wal
local wallpaper_dir = "/usr/share/backgrounds/4k/nasa-wallpapers/" -- Set wallpaper directory
local wallpapers = scan_dir(wallpaper_dir) -- Pull filenames into a table
theme.wallpaper = wallpapers[ math.random(#wallpapers) ] -- Select random image from the filename table

-- Call pywal and associated programs
local command = 'wal -i' .. theme.wallpaper .. ' --cols16 --recursive --saturate 0.9 -nq && zathura-pywal'

-- But then set colors as a callback
awful.spawn.with_shell(command, function()

    local colors = xresources.get_current_theme()

    -- Set Font
    theme.font              = "Inter Medium 18"

    theme.bg_normal         = colors.background
    theme.bg_focus          = colors.color9
    theme.bg_urgent         = colors.color3
    theme.bg_minimize       = colors.background
    theme.bg_systray        = theme.bg_normal

    theme.fg_normal         = colors.foreground
    theme.fg_focus          = theme.bg_normal
    theme.fg_urgent         = theme.fg_normal
    theme.fg_minimize       = theme.fg_normal

    theme.border_normal     = colors.background
    theme.border_focus      = colors.color9
    theme.border_marked     = theme.fg_urgent

    theme.corner_radius     = dpi(6)
    theme.useless_gap       = dpi(12)
    theme.border_width      = dpi(6)
    theme.gap_single_client = true

    -- There are other variable sets
    -- overriding the default one when
    -- defined, the sets are:
    -- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
    -- tasklist_[bg|fg]_[focus|urgent]
    -- titlebar_[bg|fg]_[normal|focus]
    -- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
    -- mouse_finder_[color|timeout|animate_timeout|radius|factor]
    -- prompt_[fg|bg|fg_cursor|bg_cursor|font]
    -- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
    -- Example:
    --theme.taglist_bg_focus = "#ff0000"

    -- Generate taglist squares:
    local taglist_square_size = dpi(8)
    theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
        taglist_square_size, theme.fg_normal
    )
    theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
        taglist_square_size, theme.fg_normal
    )
end)
-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(32)
theme.menu_width  = dpi(250)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
