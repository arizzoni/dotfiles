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

-- {{{ Menu
-- Create a launcher widget and a main menu
local mymainmenu = awful.menu({
  items = { { "Terminal", util.external.terminal },
    { "File Manager", util.external.file_manager },
    { "Web Browser",  util.external.browser },
    { "e-Mail",       util.external.mail },
    { "Screenshot",   util.external.screenshot },
    { "Music Player", util.external.music },
  }
})

local mylauncher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mymainmenu
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

  -- Create a wireless widget
  -- 󰂯 󰂰 󰂱 󰂲 󰂳 󰂴
  -- 󰤯 󰤟 󰤢 󰤥 󰤨
  -- 󰤫 󰤠 󰤣 󰤦 󰤩
  -- 󰤬 󰤡 󰤤 󰤧 󰤪
  -- 󰤮 󰤭

  local function split(inputstr, sep)
    if sep == nil then
      sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
      table.insert(t, str)
    end
    return t
  end

  s.mywireless = awful.widget.watch("iwconfig", 1,
    function(widget, stdout)
      local wireless_icon = ""
      local essid = ""
      local link_quality_string = ""
      local link_quality_float = nil

      for line in stdout:gmatch("[^\r\n]+") do
        if line:match("ESSID") then
          local words = {}
          for word in line:gmatch("%S+") do
            table.insert(words, word)
          end
          essid = string.match(words[4], [[ESSID:"([^"]+)]])
        end
        if line:match("Quality") then
          local words = {}
          for word in line:gmatch("%S+") do
            table.insert(words, word)
          end
          link_quality_string = string.match(words[2], [[Quality=([^ ]+)]])
          local numerator = split(link_quality_string, "/")[1]
          local denominator = split(link_quality_string, "/")[2]
          link_quality_float = 100 * tonumber(numerator) / tonumber(denominator)
        end
      end

      if link_quality_float <= 100 and link_quality_float > 80 then
        wireless_icon = "󰤨 "
      elseif link_quality_float <= 80 and link_quality_float > 60 then
        wireless_icon = "󰤥 "
      elseif link_quality_float <= 60 and link_quality_float > 40 then
        wireless_icon = "󰤢 "
      elseif link_quality_float <= 40 and link_quality_float > 20 then
        wireless_icon = "󰤟 "
      elseif link_quality_float <= 20 and link_quality_float > 0 then
        wireless_icon = "󰤯 "
      end

      widget:set_text(" " .. essid .. " " .. wireless_icon .. " ")
    end
  )

  s.mykeyboardlayout = mykeyboardlayout

  -- Currently only shows status of the radios
  -- TODO: interact with network utilities to determine the network -> bluez?
  -- TODO: Only show bluetooth icon if a bluetooth connection exists

  -- Airplane mode widget
  s.myairplanemode = awful.widget.watch("rfkill --output-all --noheadings", 1,
    function(widget, stdout)
      local airplane_icon = ""
      local bt_sw_status = ""
      local bt_hw_status = ""
      local wifi_sw_status = ""
      local wifi_hw_status = ""

      for line in stdout:gmatch("[^\r\n]+") do
        if line:match("Bluetooth") then
          local words = {}
          for word in line:gmatch("%S+") do
            table.insert(words, word)
          end
          bt_sw_status = words[5]
          bt_hw_status = words[6]
        end
        if line:match("Wireless LAN") then
          local words = {}
          for word in line:gmatch("%S+") do
            table.insert(words, word)
          end
          wifi_sw_status = words[5]
          wifi_hw_status = words[6]
        end
      end

      local wifi_blocked = false
      if wifi_sw_status == "blocked" or wifi_hw_status == "blocked" then
        wifi_blocked = true
      end

      local bt_blocked = false
      if bt_sw_status == "blocked" or bt_hw_status == "blocked" then
        bt_blocked = true
      end

      if bt_blocked == true and wifi_blocked == true then
        airplane_icon = "󰀝 "
      end

      widget:set_text(airplane_icon)
    end
  )

  -- Create a battery widget

  -- Discharging                󰁹 󰂂 󰂁 󰂀 󰁿 󰁾 󰁽 󰁻 󰁺 󰂎
  -- Discharging Status         󰂃 󰂑 󰂄 󰂏 󰂌 󱈑 󱟞 󱟟 󱟠 󱟡 󱟢 󱟣 󱟤 󱟥 󱟦 󱟧 󱟨 󱟩 󱧥 󱧦
  -- Wired Charging             󰂆 󰂇 󰂈 󰂉 󰂊 󰂋 󰂅
  -- Wired Charging Status      󰂍 󰂐 󱈏 󱈐

  -- Not Implemented:
  -- Wireless Charging          󰠒 󰠈 󰠉 󰠊 󰠋 󰠌 󰠍 󰠎 󰠏 󰠐 󰠇
  -- Wireless Charging Status   󰠑

  -- TODO: add status icons for battery health
  -- TODO: add support for multiple batteries
  -- TODO: Dropdown Menu

  s.mybattery = awful.widget.watch("acpi -V", 1,
    function(widget, stdout)
      local battery_icon = ""
      local words = {}
      local charging = true

      for line in stdout:gmatch("[^\r\n]+") do
        if line:match("Battery 0: Discharging") then
          charging = false
        end
        for word in line:gmatch("%S+") do
          table.insert(words, word)
        end
      end

      local charge = tonumber(string.match(words[4], "%d+"))

      if charging == true then
        if charge <= 100 and charge > 90 then
          battery_icon = "󰂅 "
        elseif charge <= 90 and charge > 80 then
          battery_icon = "󰂋 "
        elseif charge <= 80 and charge > 70 then
          battery_icon = "󰂊 "
        elseif charge <= 70 and charge > 60 then
          battery_icon = "󰂉 "
        elseif charge <= 60 and charge > 50 then
          battery_icon = "󰂈 "
        elseif charge <= 50 and charge > 40 then
          battery_icon = "󰂇 "
        elseif charge <= 40 and charge > 0 then
          battery_icon = "󰂆 "
        end
      elseif charging == false then
        if charge <= 100 and charge > 90 then
          battery_icon = "󰁹 "
        elseif charge <= 90 and charge > 80 then
          battery_icon = "󰂂 "
        elseif charge <= 80 and charge > 70 then
          battery_icon = "󰂁 "
        elseif charge <= 70 and charge > 60 then
          battery_icon = "󰂀 "
        elseif charge <= 60 and charge > 50 then
          battery_icon = "󰁿 "
        elseif charge <= 50 and charge > 40 then
          battery_icon = "󰁾 "
        elseif charge <= 40 and charge > 30 then
          battery_icon = "󰁽 "
        elseif charge <= 30 and charge > 20 then
          battery_icon = "󰁻 "
        elseif charge <= 20 and charge > 10 then
          battery_icon = "󰁺 "
        elseif charge <= 10 and charge > 0 then
          battery_icon = "󰂎 "
        end
      end
      widget:set_text(battery_icon .. tostring(charge) .. "%" .. " ")
    end
  )
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
    height   = 24,
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
        s.mysystray,
        s.mywireless,
        s.myairplanemode,
        s.mybattery,
        s.mytextclock,
      },
    }
  }
end)
