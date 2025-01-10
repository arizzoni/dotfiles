local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local Wallpaper = {}

function Wallpaper.new(screen)
	local self = setmetatable({}, Wallpaper)
	self.__index = Wallpaper
	self.screen = screen
	self.todofile = "/home/air/todo.txt"

	self.image = wibox.widget({
		image = gears.surface.crop_surface({
			surface = gears.surface.load_uncached(beautiful.wallpaper),
			ratio = self.screen.geometry.width / self.screen.geometry.height,
		}),
		widget = wibox.widget.imagebox,
	})

	self.background = wibox.widget({
		self.image,
		valign = "center",
		halign = "center",
		tiled = false,
		widget = wibox.container.tile,
	})

	self.watch, self.timer = awful.widget.watch("cat " .. self.todofile, 1)

	self.render = function()
		self.wallpaper = awful.wallpaper({
			screen = self.screen,
			widget = {
				self.background,
				{
					{
						{
							self.watch,
							valign = "top",
							halign = "left",
							tiled = false,
							widget = wibox.container.tile,
						},
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
		return true
	end

	self.watch:connect_signal("widget::redraw_needed", function()
		if self.wallpaper then
			self.wallpaper:repaint()
		end
	end)

	return self
end

return Wallpaper
