-- Create a wireless widget
-- 󰂯 󰂰 󰂱 󰂲 󰂳 󰂴
-- 󰤯 󰤟 󰤢 󰤥 󰤨
-- 󰤫 󰤠 󰤣 󰤦 󰤩
-- 󰤬 󰤡 󰤤 󰤧 󰤪
-- 󰤮 󰤭
--
-- rssi:
-- excellent > -50dBm
-- good -50dBm - -60dBm
-- fair -60dBm - -70dBm
-- weak -70dBm - -80dBm
-- poor -80dBm - or worse

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local scanning = nil
local state = nil
local network = nil
local ipv4 = nil
local ipv6 = nil
local bss = nil
local frequency = nil
local channel = nil
local security = nil
local rssi = nil
local average_rssi = nil
local rx_mode = nil
local rx_mcs = nil
local tx_mode = nil
local tx_mcs = nil
local tx_bitrate = nil
local rx_bitrate = nil

local phy0 = nil
local hci0 = nil

local rssi_number = nil
local network_icon = ""
local airplane_icon = ""

local wireless = awful.widget.watch(
	"bash -c 'iwctl station wlan0 show && rfkill --output-all --noheadings'",
	1,
	function(widget, stdout)
		for line in stdout:gmatch("[^\r\n]+") do
			if line:match("Scanning") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				scanning = words[3]
			end

			if line:match("State") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				state = words[2]
			end

			if line:match("Connected network") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				network = words[3]
			end

			if line:match("IPv4 address") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				ipv4 = words[3]
			end

			if line:match("IPv6 address") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				ipv6 = words[3]
			end

			if line:match("ConnectedBss") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				bss = words[2]
			end

			if line:match("Frequency") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				frequency = words[2]
			end

			if line:match("Channel") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				channel = words[2]
			end

			if line:match("Security") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				security = words[2]
			end

			if line:match("RSSI") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				rssi = words[2] .. words[3]
				rssi_number = tonumber(words[2])
			end

			if line:match("AverageRSSI") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				average_rssi = words[2] .. words[3]
			end

			if line:match("RxMode") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				rx_mode = words[2]
			end

			if line:match("RxMCS") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				rx_mcs = words[2]
			end

			if line:match("TxMode") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				tx_mode = words[2]
			end

			if line:match("TxMCS") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				tx_mcs = words[2]
			end

			if line:match("TxBitrate") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				tx_bitrate = words[2] .. words[3]
			end

			if line:match("RxBitrate") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				rx_bitrate = words[2] .. words[3]
			end

			if line:match("phy0") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				phy0 = words[6] .. " " .. words[7]
				if not phy0:match("unblocked") then
					phy0 = airplane_icon
				end
			end

			if line:match("hci0") then
				local words = {}
				for word in line:gmatch("%S+") do
					table.insert(words, word)
				end
				hci0 = words[5] .. " " .. words[6]
				if not hci0:match("unblocked") then
					hci0 = airplane_icon
				end
			end
		end

		if tonumber(rssi_number) > -50 then
			network_icon = "󰤨 "
		elseif tonumber(rssi_number) > -60 then
			network_icon = "󰤥 "
		elseif tonumber(rssi_number) > -70 then
			network_icon = "󰤢 "
		elseif tonumber(rssi_number) > -80 then
			network_icon = "󰤟 "
		elseif tonumber(rssi_number) > -90 then
			network_icon = "󰤯 "
		else
			network_icon = "󰤮 "
		end

		if not phy0 == nil or hci0 == nil then
			widget:set_text(" " .. airplane_icon .. " ")
		else
			widget:set_text(" " .. network .. " " .. network_icon .. " ")
		end
	end
)

wireless:connect_signal("button::release", function()
	local wifi_popup = awful.popup({
		widget = {
			{
				{
					text = "Scanning: " .. scanning,
					widget = wibox.widget.textbox,
					font = beautiful.popup_font,
				},
				{
					text = "State: " .. state,
					widget = wibox.widget.textbox,
					font = beautiful.popup_font,
				},
				{
					text = "Network: " .. network,
					widget = wibox.widget.textbox,
					font = beautiful.popup_font,
				},
				{
					text = "IPv4: " .. ipv4,
					widget = wibox.widget.textbox,
					font = beautiful.popup_font,
				},
				{
					text = "IPv6: " .. ipv6,
					widget = wibox.widget.textbox,
					font = beautiful.popup_font,
				},
				{
					text = "BSS: " .. bss,
					widget = wibox.widget.textbox,
					font = beautiful.popup_font,
				},
				{
					text = "Freq./Chan.: " .. frequency .. "/" .. channel,
					widget = wibox.widget.textbox,
					font = beautiful.popup_font,
				},
				{
					text = "Security: " .. security,
					widget = wibox.widget.textbox,
					font = beautiful.popup_font,
				},
				{
					text = "RSSI(μ) " .. rssi .. "(" .. average_rssi .. ")",
					widget = wibox.widget.textbox,
					font = beautiful.popup_font,
				},
				{
					text = "Mode(TX/RX): " .. tx_mode .. "/" .. rx_mode,
					widget = wibox.widget.textbox,
					font = beautiful.popup_font,
				},
				{
					text = "MCS(TX/RX): " .. tx_mcs .. "/" .. rx_mcs,
					widget = wibox.widget.textbox,
					font = beautiful.popup_font,
				},
				{
					text = "Bitrate(TX/RX): " .. tx_bitrate .. "/" .. rx_bitrate,
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
	wifi_popup.visible = true
end)

return wireless
