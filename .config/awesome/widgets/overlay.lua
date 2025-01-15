local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local todofile = "/home/air/.todo"

return function(screen)
	local todo_widget = wibox.widget.textbox()
	local updates_widget = wibox.widget.textbox()

	gears.timer({
		timeout = 6,
		call_now = true,
		autostart = true,
		callback = function()
			awful.spawn.easy_async_with_shell("cat " .. todofile, function(stdout)
				todo_widget:set_text(stdout)
			end)
		end,
	})

	gears.timer({
		timeout = 600,
		call_now = true,
		autostart = true,
		callback = function()
			awful.spawn.easy_async_with_shell("checkupdates", function(stdout)
				updates_widget:set_text(stdout)
			end)
		end,
	})

	screen.overlay = awful.wallpaper({
		{
			valign = "top",
			halign = "left",
			tiled = false,
			widget = todo_widget,
		},
		{
			valign = "top",
			halign = "left",
			tiled = false,
			widget = updates_widget,
		},
		left = 2 * beautiful.useless_gap,
		right = 2 * beautiful.useless_gap,
		bottom = 2 * beautiful.useless_gap,
		top = 32 + 2 * beautiful.useless_gap,
		layout = wibox.layout.flex.horizontal,
		widget = wibox.container.margin,
	})
end
