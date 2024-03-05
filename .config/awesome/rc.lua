-- If LuaRocks is installed, make sure that packages installed through it are
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

-- Configuration Modules
local bindings = require("bindings")
local util = require("util")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

--[[ Error handling ]]
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

--[[ Autostart ]]
awful.spawn.with_shell(
  'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
  'xrdb -merge <<< "awesome.started:true";' ..
  -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
  'source $HOME/.config/awesome/scripts/autostart.bash;' ..
  --
  'dex --environment Awesome --autostart'
)

--[[ Variable definitions ]]
-- Initialize theme
beautiful.init(gfs.get_xdg_config_home() .. "awesome/theme.lua")

-- Default modkey.
local modkey = bindings.mod.super

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

-- Menubar configuration
menubar.utils.terminal = util.external.terminal -- Set the terminal for applications that require it

--[[ Status Bar ]]
local bar = require("bar")

--[[ Global Bindings ]]
root.buttons(bindings.global.mouse)
root.keys(bindings.global.key)

--[[ Client Rules ]]
local rules = require("rules")

--[[ C API (Signals) ]]
local signals = require("signals")

collectgarbage("collect")
