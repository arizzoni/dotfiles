local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local mean_core_temp = 0
local len = 0
local core_temps = {}
local temp_icon = ""

local sensors = awful.widget.watch("sensors", 1, function(widget, stdout)
	for line in stdout:gmatch("[^\r\n]+") do
		for idx = 0, 7, -1 do
			if line:match("Core " .. idx .. ":") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				core_temps.insert(words[2])
			end
		end

		for _, v in pairs(core_temps) do
			mean_core_temp = mean_core_temp + v
			len = len + 1
		end
		mean_core_temp = mean_core_temp / len

		if tonumber(mean_core_temp) > 80 then
			temp_icon = " "
		elseif tonumber(mean_core_temp) > -70 then
			temp_icon = " "
		elseif tonumber(mean_core_temp) > -60 then
			temp_icon = " "
		elseif tonumber(mean_core_temp) > -50 then
			temp_icon = " "
		else
			temp_icon = " "
		end

		widget:set_text(" " .. temp_icon .. " ")
	end
end)

sensors:connect_signal("button::release", function()
	local sensors_popup = awful.popup({
		widget = {
			{
				{
					text = "Mean Core Temperature: " .. mean_core_temp,
					widget = wibox.widget.textbox,
					font = beautiful.popup_font,
				},
				layout = wibox.layout.fixed.vertical,
			},
			margins = 10,
			widget = wibox.container.margin,
		},
		screen = awful.screen.focused(),
		border_color = beautiful.border_normal,
		border_width = 5,
		preferred_positions = "bottom",
		preferred_anchors = "middle",
		placement = awful.placement.next_to,
		shape = gears.shape.rounded_rect,
		ontop = true,
		visible = true,
		hide_on_right_click = true,
		type = "dock",
		honor_workarea = true,
	})
	sensors_popup.visible = true
end)

return sensors
