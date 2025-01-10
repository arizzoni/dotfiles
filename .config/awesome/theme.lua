-- theme.lua - Theme for AwesomeWM
-- V0.2
-- Alessandro Rizzoni

local xresources = require("beautiful.xresources")
local shape = require("gears.shape")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}
theme.name = "MetaTheme"

local colors = xresources.get_current_theme()

local wal_cache = io.open(gfs.get_xdg_cache_home() .. "wallust/wallpaper", "r")
if wal_cache ~= nil then
	theme.wallpaper = wal_cache:read()
	wal_cache:close()
end

theme.fontsize = "14"
theme.font = "sans-serif" .. " " .. theme.fontsize
theme.prompt_font = "monospace" .. " " .. theme.fontsize
theme.popup_font = "sans-serif" .. " " .. theme.fontsize
theme.menubar_font = "sans-serif" .. " " .. theme.fontsize

theme.opacity = 1.0
theme.border_width = 2
theme.corner_radius = theme.border_width
theme.titlebar_size = 2 * theme.fontsize
theme.statusbarsize = 3 * theme.fontsize
theme.useless_gap = 4 * theme.border_width
theme.gap_single_client = true

theme.tooltip_font = theme.font
theme.tooltip_opacity = 0.9
theme.tooltip_border_width = theme.border_width

theme.mouse_finder_timeout = 1.0
theme.mouse_finder_animate_timeout = true
theme.mouse_finder_radius = 2 * theme.titlebar_size
theme.mouse_finder_factor = 0.8

theme.notification_font = theme.font
theme.notification_border_width = theme.border_width
theme.notification_shape = function(cr, width, height)
	shape.rounded_rect(cr, width, height, theme.corner_radius)
end
theme.notification_opacity = theme.tooltip_opacity

theme.hotkeys_border_width = theme.border_width
theme.hotkeys_shape = theme.notification_shape
theme.hotkeys_opacity = theme.tooltip_opacity
theme.hotkeys_group_margin = theme.font_size
theme.hotkeys_font = theme.font
theme.hotkeys_description_font = theme.font

theme.menu_border_width = theme.border_width
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = theme.titlebar_size
theme.menu_width = 6 * theme.titlebar_size

theme.bg_normal = colors.background
theme.fg_normal = colors.foreground
theme.border_normal = theme.bg_normal

theme.bg_focus = colors.color4
theme.fg_focus = theme.bg_normal
theme.border_focus = theme.bg_focus

theme.bg_urgent = colors.color10
theme.fg_urgent = theme.fg_normal
theme.border_marked = theme.bg_urgent

theme.bg_minimize = theme.bg_normal
theme.fg_minimize = theme.fg_normal

theme.bg_systray = theme.bg_normal
theme.fg_systray = theme.fg_normal

theme.taglist_bg_focus = theme.bg_focus
theme.taglist_fg_focus = theme.fg_focus

theme.taglist_bg_urgent = theme.bg_urgent
theme.taglist_fg_urgent = theme.fg_urgent

theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_fg_occupied = theme.fg_normal

theme.taglist_bg_empty = theme.bg_normal
theme.taglist_fg_empty = theme.bg_normal

theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_fg_focus = theme.fg_focus

theme.tasklist_bg_urgent = theme.bg_urgent
theme.tasklist_fg_urgent = theme.fg_urgent

theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_normal = theme.fg_normal

theme.titlebar_bg_focus = theme.bg_focus
theme.titlebar_fg_focus = theme.fg_focus

-- theme.progressbar_bg = theme.bg_normal
theme.progressbar_bg = theme.bg_normal
theme.progressbar_fg = theme.fg_normal
theme.progressbar_shape = shape.rounded_rect
theme.progressbar_border_color = theme.border_normal
theme.progressbar_border_width = theme.border_width
theme.progressbar_bar_shape = theme.notification_shape
theme.progressbar_border_width = theme.border_width
theme.progressbar_border_color = theme.border_normal
theme.progressbar_margins = theme.useless_gap
theme.progressbar_paddings = theme.useless_gap

theme.tooltip_bg_color = theme.bg_normal
theme.tooltip_fg_color = theme.fg_normal
theme.tooltip_border_color = theme.border_marked

theme.mouse_finder_color = theme.border_marked

theme.prompt_bg = theme.bg_normal
theme.prompt_fg = theme.fg_normal
theme.prompt_bg_cursor = theme.bg_normal
theme.prompt_fg_cursor = theme.fg_normal

theme.hotkeys_bg = theme.bg_normal
theme.hotkeys_fg = theme.fg_normal
theme.hotkeys_border_color = theme.border_marked
theme.hotkeys_modifier_bg = theme.bg_focus
theme.hotkeys_modifier_fg = theme.fg_focus
theme.hotkeys_label_bg = theme.bg_normal
theme.hotkeys_label_fg = theme.fg_normal

theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.notification_border_color = theme.border_normal

theme.menu_bg_normal = theme.bg_normal
theme.menu_fg_normal = theme.fg_normal
theme.menu_border_color = theme.border_normal

theme.menu_bg_focus = theme.bg_focus
theme.menu_fg_focus = theme.fg_focus

theme.menubar_bg_normal = theme.bg_normal
theme.menubar_fg_normal = theme.fg_normal
theme.menubar_border_width = theme.border_width
theme.menubar_border_color = theme.fg_normal

theme.menubar_bg_focus = theme.bg_focus
theme.menubar_fg_focus = theme.fg_focus

theme.titlebar_close_button_normal = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "default/titlebar/maximized_focus_active.png"

theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

theme.icon_theme = "Papirus-Dark"

return theme
