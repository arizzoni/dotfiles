--If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local gfs = require("gears.filesystem")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Startup Error",
    text = awesome.startup_errors
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Runtime Error",
      text = tostring(err)
    })
    in_error = false
  end)
end
-- }}}

-- {{{ Autostart
awful.spawn.with_shell(
  'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
  'xrdb -merge <<< "awesome.started:true";' ..
  -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
  'source $HOME/.config/awesome/scripts/autostart.bash;' ..
  --
  'dex --environment Awesome --autostart'
)

-- {{{ Variable definitions
-- Initialize theme
beautiful.init(gfs.get_xdg_config_home() .. "awesome/theme.lua")
-- Default terminal and editor to run.
local terminal = "alacritty"
-- local editor = os.getenv("EDITOR") or "nvim"
-- local editor_cmd = terminal .. " -e " .. editor
local editor_cmd = "neovide -- -c 'Vex'"

-- Default modkey.
local modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.floating,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local mymainmenu = awful.menu({
  items = { { "Terminal", terminal },
    { "File Manager", "thunar" },
    { "Internet",     "firefox" },
    { "Mail",         "himalaya" },
    { "Screenshot",   "screenshot -c" },
    { "Radio",        "goodvibes" },
  }
})

local mylauncher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
-- local mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
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
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),

  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),

  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),

  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end))

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
awful.screen.set_auto_dpi_enabled(true)
screen.connect_signal("property::geometry", set_wallpaper)
awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt({ prompt = " $ " })

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)

  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create a systray widget
  s.mysystray = wibox.widget.systray()
  s.mysystray.set_base_size(48)

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

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    opacity = 1.0,
    type = "dock",
    shape = gears.shape.rectangle,
    height = 24,
  })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mylayoutbox,
      mylauncher,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    {             -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      s.mysystray,
      s.mywireless,
      s.myairplanemode,
      s.mybattery,
      s.mytextclock,
    },
  }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
  awful.button({}, 3, function() mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
local globalkeys = gears.table.join(
  awful.key({ modkey, }, "s", hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }),

  awful.key({ modkey, }, "Left", awful.tag.viewprev,
    { description = "view previous", group = "tag" }),

  awful.key({ modkey, }, "Right", awful.tag.viewnext,
    { description = "view next", group = "tag" }),

  awful.key({ modkey, }, "Escape", awful.tag.history.restore,
    { description = "go back", group = "tag" }),

  awful.key({ modkey, }, "j",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" }
  ),
  awful.key({ modkey, }, "k",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" }
  ),
  awful.key({ modkey, }, "w", function() mymainmenu:show() end,
    { description = "show main menu", group = "awesome" }),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }),
  awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }),

  awful.key({ modkey, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "go back", group = "client" }),

  -- Standard program
  awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
    { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey, }, "e", function() awful.spawn(editor_cmd) end,
    { description = "open editor", group = "launcher" }),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
    { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "q", awesome.quit,
    { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
    { description = "increase the number of master clients", group = "layout" }),
  awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }),
  awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }),
  awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
    { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
    { description = "select previous", group = "layout" }),

  awful.key({ modkey, "Control" }, "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal(
          "request::activate", "key.unminimize", { raise = true }
        )
      end
    end,
    { description = "restore minimized", group = "client" }),

  -- Prompt
  awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
    { description = "run prompt", group = "launcher" }),

  awful.key({ modkey }, "x",
    function()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    { description = "lua execute prompt", group = "awesome" }),

  -- Menubar
  awful.key({ modkey }, "p", function() menubar.show() end,
    { description = "show the menubar", group = "launcher" }),
  awful.key({ modkey, }, "b", function() awful.spawn(" xfce4-appfinder -c") end),

  -- Volume Keys
  awful.key({}, "XF86AudioLowerVolume", function()
    awful.util.spawn("amixer set Master 5%-")
  end),

  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.util.spawn("amixer set Master 5%+")
  end),

  awful.key({}, "XF86AudioMute", function()
    awful.util.spawn("amixer set Master toggle")
  end),

  -- Screenshot on prtscn using scrot
  awful.key({}, "XF86Print", function()
    awful.spawn.spawn("screenshot -c")
  end),

  -- Map xbacklight for brightness keys
  awful.key({}, "XF86MonBrightnessDown", function()
    awful.spawn.spawn("xbacklight -dec 10")
  end),

  awful.key({}, "XF86MonBrightnessUp", function()
    awful.spawn.spawn("xbacklight -inc 10")
  end),

  -- Airplane mode
  awful.key({}, "XF86RFKill", function()
    awful.spawn.spawn("rfkill toggle all")
  end)
)

local clientkeys = gears.table.join(
  awful.key({ modkey, }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end,
    { description = "close", group = "client" }),

  awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }),
  awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }),
  awful.key({ modkey, }, "o", function(c) c:move_to_screen() end,
    { description = "move to screen", group = "client" }),
  awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end,
    { description = "toggle keep on top", group = "client" }),

  awful.key({ modkey, }, "n",
    function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    { description = "minimize", group = "client" }),

  awful.key({ modkey, }, "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "(un)maximize", group = "client" }),

  awful.key({ modkey, "Control" }, "m",
    function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    { description = "(un)maximize vertically", group = "client" }),

  awful.key({ modkey, "Shift" }, "m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function()
        local current_screen = awful.screen.focused()
        local tag = current_screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { description = "view tag #" .. i, group = "tag" }),

    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function()
        local current_screen = awful.screen.focused()
        local tag = current_screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = "toggle tag #" .. i, group = "tag" }),

    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = "move focused client to tag #" .. i, group = "tag" }),

    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

local clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),

  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),

  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA",   -- Firefox addon DownThemAll.
        "copyq", -- Includes session name in class.
        "pinentry",
      },
      class = {
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "xtightvncviewer" },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow",   -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = { floating = true }
  },

  -- app launcher TODO: make an app launcher with a prompt widget
  {
    rule_any = {
      instance = { "xfce4-appfinder" },
    },
    properties = {
      callback = function(c) awful.placement.centered(c) end,
      focus = true,
      urgent = true,
      ontop = true,
      skip_taskbar = true,
    }
  },

  -- Add titlebars to normal clients and dialogs
  {
    rule_any = { type = { "dialog" }
    },
    properties = { titlebars_enabled = true }
  },

  {
    rule_any = {
      class = { "conky" }
    },
    properties = { border_width = 0 }
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),

    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c):setup {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },

    {   -- Middle
      { -- Title
        align  = "center",
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },

    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

-- Enable rounded corners
client.connect_signal("manage", function(c)
  c.shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, beautiful.corner_radius)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

collectgarbage("collect")
