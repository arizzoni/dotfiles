local awful = require("awful")
-- Create a battery widget

-- Discharging                󰁹 󰂂 󰂁 󰂀 󰁿 󰁾 󰁽 󰁻 󰁺 󰂎
-- Discharging Status         󰂃 󰂑 󰂄 󰂏 󰂌 󱈑 󱟞 󱟟 󱟠 󱟡 󱟢 󱟣 󱟤 󱟥 󱟦 󱟧 󱟨 󱟩 󱧥 󱧦
-- Wired Charging             󰂆 󰂇 󰂈 󰂉 󰂊 󰂋 󰂅
-- Wired Charging Status      󰂍 󰂐 󱈏 󱈐

-- Not Implemented:
-- Wireless Charging          󰠒 󰠈 󰠉 󰠊 󰠋 󰠌 󰠍 󰠎 󰠏 󰠐 󰠇
-- Wireless Charging Status   󰠑

-- TODO: add status icons for battery health
-- TODO: add support for multiple batteries
-- TODO: Dropdown Menu

mybattery = awful.widget.watch("acpi -V", 1, function(widget, stdout)
	local battery_icon = ""
	local words = {}
	local charging = true

	for line in stdout:gmatch("[^\r\n]+") do
		if line:match("Battery 0: Discharging") then
			charging = false
		end
		for word in line:gmatch("%S+") do
			table.insert(words, word)
		end
	end

	local charge = tonumber(string.match(words[4], "%d+"))

	if charging == true then
		if charge <= 100 and charge > 90 then
			battery_icon = "󰂅 "
		elseif charge <= 90 and charge > 80 then
			battery_icon = "󰂋 "
		elseif charge <= 80 and charge > 70 then
			battery_icon = "󰂊 "
		elseif charge <= 70 and charge > 60 then
			battery_icon = "󰂉 "
		elseif charge <= 60 and charge > 50 then
			battery_icon = "󰂈 "
		elseif charge <= 50 and charge > 40 then
			battery_icon = "󰂇 "
		elseif charge <= 40 and charge > 0 then
			battery_icon = "󰂆 "
		end
	elseif charging == false then
		if charge <= 100 and charge > 90 then
			battery_icon = "󰁹 "
		elseif charge <= 90 and charge > 80 then
			battery_icon = "󰂂 "
		elseif charge <= 80 and charge > 70 then
			battery_icon = "󰂁 "
		elseif charge <= 70 and charge > 60 then
			battery_icon = "󰂀 "
		elseif charge <= 60 and charge > 50 then
			battery_icon = "󰁿 "
		elseif charge <= 50 and charge > 40 then
			battery_icon = "󰁾 "
		elseif charge <= 40 and charge > 30 then
			battery_icon = "󰁽 "
		elseif charge <= 30 and charge > 20 then
			battery_icon = "󰁻 "
		elseif charge <= 20 and charge > 10 then
			battery_icon = "󰁺 "
		elseif charge <= 10 and charge > 0 then
			battery_icon = "󰂎 "
		end
	end
	widget:set_text(battery_icon .. tostring(charge) .. "%" .. " ")
end)

return mybattery
