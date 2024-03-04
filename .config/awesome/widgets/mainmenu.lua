local awful = require("awful")
local util = require("util")

-- Create a launcher widget and a main menu
local mainmenu = awful.menu({
  items = { { "Terminal", util.terminal },
    { "File Manager", "thunar" },
    { "Internet",     "firefox" },
    { "Mail",         "himalaya" },
    { "Screenshot",   "screenshot -c" },
    { "Radio",        "goodvibes" },
  }
})

return mainmenu
