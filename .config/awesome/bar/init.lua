local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local menubar = require("menubar")

local bindings = require("bindings")
local modkey = bindings.mod.super
local util = require("util")

--[[ Menu ]]
-- Menubar configuration
menubar.utils.terminal = util.external.terminal -- Set the terminal for applications that require it

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

local mylauncher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mymainmenu,
})

screen.connect_signal("request::desktop_decoration", function(s)
  -- {{{ Wibar

  -- Other widgets TBD
  -- Cooling Status                 
  -- 󰒳 󰒲 screensaver
  -- bluetooth

  -- Create an audio widget
  -- Show mute icon when volume is zero
  -- Show microphone indicator icon
  -- Audio Status               󰕾 󰕿 󰖀 󰝞 󰝟 󰝝 󰖁
  -- Microphone Status          󰍭 󰍬 󰍮 󰍯 󱦉 󱦊

  s.mywireless = require("bar.wireless")

  s.mykeyboardlayout = mykeyboardlayout

  -- Currently only shows status of the radios
  -- TODO: interact with network utilities to determine the network -> bluez?
  -- TODO: Only show bluetooth icon if a bluetooth connection exists

  -- Airplane mode widget
  -- s.myairplanemode = require("bar.airplanemode")
  -- Battery indicator
  -- s.mybattery = require("bar.battery")

  -- Keyboard map indicator and switcher
  -- local mykeyboardlayout = awful.widget.keyboardlayout()

  -- Create a textclock widget
  s.mytextclock = wibox.widget.textclock("%I:%M %p", 1)

  -- Create a popup calendar widget attached to the textclock
  s.mycalendar_popup = awful.widget.calendar_popup.month({
    position = "tr",
    screen = s,
    opacity = 1,
    bg = beautiful.notification_bg,
    font = beautiful.font,
    spacing = beautiful.corner_radius,
    margin = beautiful.corner_radius,
    week_numbers = false,
    start_sunday = true,
    long_weekdays = true,
    style_month = {
      fg_color = beautiful.fg_urgent,
      bg_color = beautiful.bg_urgent,
      padding = beautiful.corner_radius,
      border_width = 0,
      border_color = beautiful.fg_urgent,
      opacity = 1,
    },
    style_header = {
      fg_color = beautiful.fg_urgent,
      bg_color = beautiful.bg_urgent,
      padding = beautiful.corner_radius,
      border_width = 0,
      border_color = beautiful.bg_urgent,
      opacity = 1,
    },
    style_weekday = {
      fg_color = beautiful.fg_urgent,
      bg_color = beautiful.bg_urgent,
      padding = beautiful.corner_radius,
      border_width = 0,
      border_color = beautiful.bg_urgent,
      opacity = 1,
    },
    style_weeknumber = {
      fg_color = beautiful.fg_urgent,
      bg_color = beautiful.bg_urgent,
      padding = beautiful.corner_radius,
      border_width = 0,
      border_color = beautiful.bg_urgent,
      opacity = 1,
    },
    style_normal = {
      fg_color = beautiful.fg_urgent,
      bg_color = beautiful.bg_urgent,
      padding = beautiful.corner_radius,
      border_width = 0,
      border_color = beautiful.bg_urgent,
      opacity = 1,
    },
    style_focus = {
      fg_color = beautiful.bg_focus,
      bg_color = beautiful.bg_urgent,
      padding = beautiful.corner_radius,
      border_width = beautiful.border_width,
      border_color = beautiful.bg_focus,
      opacity = 1,
    }
  })
  s.mycalendar_popup:attach(s.mytextclock, "tr")

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox {
    screen  = s,
    buttons = {
      awful.button({}, 1, function() awful.layout.inc(1) end),
      awful.button({}, 3, function() awful.layout.inc(-1) end),
      awful.button({}, 4, function() awful.layout.inc(-1) end),
      awful.button({}, 5, function() awful.layout.inc(1) end),
    }
  }

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = {
      awful.button({}, 1, function(t) t:view_only() end),
      awful.button({ modkey }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
      awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
      awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
    }
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = {
      awful.button({}, 1, function(c)
        c:activate { context = "tasklist", action = "toggle_minimization" }
      end),
      awful.button({}, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
      awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
      awful.button({}, 5, function() awful.client.focus.byidx(1) end),
    }
  }

  -- Create the wibox
  s.mywibox = awful.wibar {
    position = "top",
    screen   = s,
    height   = 32,
    widget   = {
      layout = wibox.layout.align.horizontal,
      {       -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        s.mylayoutbox,
        mylauncher,
        s.mytaglist,
        s.mypromptbox,
      },
      s.mytasklist,       -- Middle widget
      {                   -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        -- mykeyboardlayout,
        wibox.widget.systray(),
        s.mywireless,
        -- s.myairplanemode,
        -- s.mybattery,
        s.mytextclock,
      },
    }
  }
end)
