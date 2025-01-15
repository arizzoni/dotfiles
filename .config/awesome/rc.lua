-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

require("awful.hotkeys_popup.keys")
require("awful.autofocus")

--[[ Error Handling ]]
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification({
		urgency = "critical",
		title = "AwesomeWM Startup Error" .. (startup and " during startup!" or "!"),
		message = message,
	})
end)

beautiful.init("/home/air/.config/awesome/theme.lua")

require("util")
require("bindings")
require("rules")
require("signals")

local render_wallpaper = require("widgets.wallpaper")
local render_statusbar = require("bar")

screen.connect_signal("request::desktop_decoration", function(s)
	render_statusbar(s)
end)

screen.connect_signal("request::wallpaper", function(s)
	render_wallpaper(s)
end)

-- Run garbage collector regularly to prevent memory leaks
gears.timer({
	timeout = 30,
	autostart = true,
	callback = function()
		collectgarbage()
	end,
})
