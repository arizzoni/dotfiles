local awful = require("awful")
local beautiful = require("beautiful")

-- Create a popup calendar widget attached to the textclock
local calendar = function(s)
	return awful.widget.calendar_popup.month({
		position = "tr",
		screen = s,
		opacity = beautiful.tooltip_opacity,
		bg = beautiful.notification_bg,
		font = beautiful.font,
		spacing = beautiful.corner_radius,
		margin = beautiful.corner_radius,
		week_numbers = false,
		start_sunday = true,
		long_weekdays = true,
		style_month = {
			fg_color = beautiful.fg_urgent,
			bg_color = beautiful.bg_urgent,
			padding = beautiful.corner_radius,
			border_width = 0,
			border_color = beautiful.fg_urgent,
			opacity = beautiful.tooltip_opacity,
		},
		style_header = {
			fg_color = beautiful.fg_urgent,
			bg_color = beautiful.bg_urgent,
			padding = beautiful.corner_radius,
			border_width = 0,
			border_color = beautiful.bg_urgent,
			opacity = beautiful.tooltip_opacity,
		},
		style_weekday = {
			fg_color = beautiful.fg_urgent,
			bg_color = beautiful.bg_urgent,
			padding = beautiful.corner_radius,
			border_width = 0,
			border_color = beautiful.bg_urgent,
			opacity = beautiful.tooltip_opacity,
		},
		style_weeknumber = {
			fg_color = beautiful.fg_urgent,
			bg_color = beautiful.bg_urgent,
			padding = beautiful.corner_radius,
			border_width = 0,
			border_color = beautiful.bg_urgent,
			opacity = beautiful.tooltip_opacity,
		},
		style_normal = {
			fg_color = beautiful.fg_urgent,
			bg_color = beautiful.bg_urgent,
			padding = beautiful.corner_radius,
			border_width = 0,
			border_color = beautiful.bg_urgent,
			opacity = beautiful.tooltip_opacity,
		},
		style_focus = {
			fg_color = beautiful.bg_focus,
			bg_color = beautiful.bg_urgent,
			padding = beautiful.corner_radius,
			border_width = beautiful.border_width,
			border_color = beautiful.bg_focus,
			opacity = beautiful.tooltip_opacity,
		},
	})
end

return calendar
