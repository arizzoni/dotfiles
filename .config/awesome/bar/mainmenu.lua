local awful = require("awful")
local util = require("util")

-- Create a launcher widget and a main menu
local mainmenu = awful.menu({
  items = { { "Terminal", util.external.terminal },
    { "File Manager", util.external.file_manager },
    { "Web Browser",     util.external.browser },
    { "e-Mail",         util.external.mail },
    { "Screenshot",   util.external.screenshot },
    { "Music Player",        util.external.music },
  }
})

return mainmenu
