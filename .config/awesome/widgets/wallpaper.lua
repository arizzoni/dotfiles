local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

return function(s)
	local todofile = "/home/air/.todo"

	local image = wibox.widget({
		image = gears.surface.crop_surface({
			surface = gears.surface.load_uncached(beautiful.wallpaper),
			ratio = s.geometry.width / s.geometry.height,
		}),
		widget = wibox.widget.imagebox,
	})

	local background = wibox.widget({
		image,
		valign = "center",
		halign = "center",
		tiled = false,
		widget = wibox.container.tile,
	})

	local todo, _ = awful.widget.watch("cat " .. todofile, 600)
	local updates, _ = awful.widget.watch("checkupdates", 600)

	local overlay = wibox.widget({
		{
			valign = "top",
			halign = "left",
			tiled = false,
			widget = todo,
		},
		{
			valign = "top",
			halign = "left",
			tiled = false,
			widget = updates,
		},
		layout = wibox.layout.flex.horizontal,
	})

	s.wallpaper = awful.wallpaper({
		screen = s,
		widget = {
			background,
			{
				{
					overlay,
					fg = beautiful.fg_normal,
					widget = wibox.container.background,
				},
				left = 2 * beautiful.useless_gap,
				right = 2 * beautiful.useless_gap,
				bottom = 2 * beautiful.useless_gap,
				top = 32 + 2 * beautiful.useless_gap,
				widget = wibox.container.margin,
			},
			layout = wibox.layout.stack,
		},
	})

	todo:connect_signal("widget::redraw_needed", function()
		if s.wallpaper then
			s.wallpaper:repaint()
		end
	end)

	updates:connect_signal("widget::redraw_needed", function()
		if s.wallpaper then
			s.wallpaper:repaint()
		end
	end)
end
