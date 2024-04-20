-- theme.lua - Theme for AwesomeWM
-- V0.2
-- Alessandro Rizzoni

local xresources = require("beautiful.xresources") -- AwesomeWM Xresources interface
local shape = require("gears.shape")               -- AwesomeWM shapes
local gfs = require("gears.filesystem")            -- AwesomeWM filesystem utility
local themes_path = gfs.get_themes_dir()           -- AwesomeWM default themes path

local theme = {}                                   -- Initialize theme table
theme.name = 'MetaTheme'                           -- Theme name for export

-- Get colors from Xresources
local colors = xresources.get_current_theme()

-- Get wallpaper
local wal_cache = io.open(gfs.get_xdg_cache_home() .. 'wal/wal', 'r')
if wal_cache ~= nil then
  theme.wallpaper = wal_cache:read()
  wal_cache:close()
end

-- Assign colors:
theme.bg_normal                                 = colors.background
theme.fg_normal                                 = colors.foreground
theme.border_normal                             = theme.bg_normal

theme.bg_focus                                  = colors.color4
theme.fg_focus                                  = theme.bg_normal
theme.border_focus                              = theme.bg_focus

theme.bg_urgent                                 = colors.color10
theme.fg_urgent                                 = theme.fg_normal
theme.border_marked                             = theme.bg_urgent

theme.bg_minimize                               = theme.bg_normal
theme.fg_minimize                               = theme.fg_normal

theme.bg_systray                                = theme.bg_normal
theme.fg_systray                                = theme.fg_normal

theme.taglist_bg_focus                          = theme.bg_focus
theme.taglist_fg_focus                          = theme.fg_focus

theme.taglist_bg_urgent                         = theme.bg_urgent
theme.taglist_fg_urgent                         = theme.fg_urgent

theme.taglist_bg_occupied                       = theme.bg_normal
theme.taglist_fg_occupied                       = theme.fg_normal

theme.taglist_bg_empty                          = theme.bg_normal
theme.taglist_fg_empty                          = theme.bg_normal

theme.tasklist_bg_focus                         = theme.bg_focus
theme.tasklist_fg_focus                         = theme.fg_focus

theme.tasklist_bg_urgent                        = theme.bg_urgent
theme.tasklist_fg_urgent                        = theme.fg_urgent

theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_normal                        = theme.fg_normal

theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_fg_focus                         = theme.fg_focus

theme.tooltip_bg_color                          = theme.bg_normal
theme.tooltip_fg_color                          = theme.fg_normal
theme.tooltip_border_color                      = theme.border_marked

theme.mouse_finder_color                        = theme.border_marked

theme.prompt_bg                                 = theme.bg_normal
theme.prompt_fg                                 = theme.fg_normal
theme.prompt_bg_cursor                          = theme.bg_normal
theme.prompt_fg_cursor                          = theme.fg_normal

theme.hotkeys_bg                                = theme.bg_normal
theme.hotkeys_fg                                = theme.fg_normal
theme.hotkeys_border_color                      = theme.border_marked
theme.hotkeys_modifier_bg                       = theme.bg_focus
theme.hotkeys_modifier_fg                       = theme.fg_focus
theme.hotkeys_label_bg                          = theme.bg_normal
theme.hotkeys_label_fg                          = theme.fg_normal

theme.notification_bg                           = theme.bg_normal
theme.notification_fg                           = theme.fg_normal
theme.notification_border_color                 = theme.border_normal

theme.menu_bg_normal                            = theme.bg_normal
theme.menu_fg_normal                            = theme.fg_normal
theme.menu_border_color                         = theme.border_normal

theme.menu_bg_focus                             = theme.bg_focus
theme.menu_fg_focus                             = theme.fg_focus


-- Theme settings
theme.font                                      = "Iosevka, Symbols Nerd Font 14"
theme.prompt_font                               = "Iosevka Term, Symbols Nerd Font Mono 13"

theme.opacity                                   = 1.0
theme.corner_radius                             = 0
theme.useless_gap                               = 0
theme.border_width                              = 0
theme.gap_single_client                         = true

theme.tooltip_font                              = theme.font
theme.tooltip_opacity                           = theme.opacity
theme.tooltip_border_width                      = theme.border_width

theme.mouse_finder_timeout                      = 1.0
theme.mouse_finder_animate_timeout              = true
theme.mouse_finder_radius                       = 64
theme.mouse_finder_factor                       = 0.8

theme.hotkeys_border_width                      = theme.border_width
theme.hotkeys_shape                             = shape.rounded_rect
theme.hotkeys_opacity                           = theme.tooltip_opacity
theme.hotkeys_group_margin                      = 12
theme.hotkeys_font                              = theme.font
theme.hotkeys_description_font                  = theme.font

theme.notification_font                         = theme.font
theme.notification_border_width                 = theme.border_width
theme.notification_shape                        = shape.rounded_rect
theme.notification_opacity                      = theme.opacity

theme.menu_border_width                         = theme.border_width
theme.menu_submenu_icon                         = themes_path .. "default/submenu.png"
theme.menu_height                               = 24
theme.menu_width                                = 150

-- Define the image to load
theme.titlebar_close_button_normal              = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = themes_path .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal           = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = themes_path .. "default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
-- theme.layout_floating                           = themes_path .. "default/layouts/floatingw.png"
theme.layout_fairh                              = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv                              = themes_path .. "default/layouts/fairvw.png"
-- theme.layout_magnifier                          = themes_path .. "default/layouts/magnifierw.png"
-- theme.layout_max                                = themes_path .. "default/layouts/maxw.png"
-- theme.layout_fullscreen                         = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom                         = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft                           = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile                               = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop                            = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral                             = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle                            = themes_path .. "default/layouts/dwindlew.png"
-- theme.layout_cornernw                           = themes_path .. "default/layouts/cornernww.png"
-- theme.layout_cornerne                           = themes_path .. "default/layouts/cornernew.png"
-- theme.layout_cornersw                           = themes_path .. "default/layouts/cornersww.png"
-- theme.layout_cornerse                           = themes_path .. "default/layouts/cornersew.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme                                = "Papirus-Dark"

theme.calendar_style_month                      = {
  markup = nil,
  fg_color = theme.fg_focus,
  bg_color = theme.bg_normal,
  opacity = theme.opacity,
}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
