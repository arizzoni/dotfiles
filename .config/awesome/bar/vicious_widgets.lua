local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")

local vicious_widgets = {}

-- Date Widget
vicious_widgets.datewidget = wibox.widget.textbox()
vicious.register(vicious_widgets.datewidget, vicious.widgets.date, "%b %d, %R")

-- Memory Widget
vicious_widgets.memwidget = wibox.widget.textbox()
vicious.cache(vicious.widgets.mem)
vicious.register(vicious_widgets.memwidget, vicious.widgets.mem, "$1 ($2MiB/$3MiB)", 1)

-- HDD Temperature Widget
vicious_widgets.hddtempwidget = wibox.widget.textbox()
vicious.register(vicious_widgets.hddtempwidget, vicious.widgets.hddtemp, "${/dev/sda} °C", 1)

-- Battery Widget
vicious_widgets.batwidget = wibox.widget.progressbar()
local batbox = wibox.layout.flex(
    wibox.widget{ { max_value = 1, widget = vicious_widgets.batwidget,
                    border_width = 0.5, border_color = "#000000",
                    color = { type = "linear",
                              from = { 0, 0 },
                              to = { 0, 30 },
                              stops = { { 0, "#AECF96" },
                                        { 1, "#FF5656" } } } },
                  forced_height = 10, forced_width = 8,
                  direction = 'east', color = beautiful.fg_widget,
                  layout = wibox.container.rotate },
    1, 1, 3, 3)
vicious.register(vicious_widgets.batwidget, vicious.widgets.bat, "$2", 1, "BAT0")

-- CPU Widget
vicious_widgets.cpuwidget = awful.widget.graph()
vicious_widgets.cpuwidget:set_width(50)
vicious_widgets.cpuwidget:set_background_color"#494B4F"
vicious_widgets.cpuwidget:set_color{ type = "linear", from = { 0, 0 }, to = { 50, 0 },
                     stops = { { 0, "#FF5656" },
                               { 0.5, "#88A175" },
                               { 1, "#AECF96" } } }
vicious.register(vicious_widgets.cpuwidget, vicious.widgets.cpu, "$1", 1)

return vicious_widgets
