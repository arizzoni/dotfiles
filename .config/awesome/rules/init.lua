local awful = require("awful")
local beautiful = require("beautiful")
local bindings = require("bindings")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
-- local bindings = require("bindings")
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = bindings.client.key,
      buttons = bindings.client.mouse,
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
    rule_any = { class = "keepassxc" },
    properties = {
      screen = 1,
      tag = "9",
      ontop = true,
    }
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
}
-- }}}
