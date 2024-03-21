-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")

-- Direct imports
require("awful.hotkeys_popup.keys")
require("awful.autofocus")

--[[ Error Handling ]]
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "AwesomeWM Startup Error" .. (startup and " during startup!" or "!"),
        message = message
    }
end)

--[[ Variable Definitions and Imports ]]
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme.lua")
local util = require("util")
local bindings = require("bindings")
local rules = require("rules")
local bar = require("bar")
