local M = {}

local awful = require("awful")

  -- Airplane mode widget
M.airplanemode = awful.widget.watch("rfkill --output-all --noheadings", 1,
  function(widget, stdout)
    local airplane_icon = ""
    local bt_sw_status = ""
    local bt_hw_status = ""
    local wifi_sw_status = ""
    local wifi_hw_status = ""

    for line in stdout:gmatch("[^\r\n]+") do
      if line:match("Bluetooth") then
        local words = {}
        for word in line:gmatch("%S+") do
          table.insert(words, word)
        end
        bt_sw_status = words[5]
        bt_hw_status = words[6]
      end
      if line:match("Wireless LAN") then
        local words = {}
        for word in line:gmatch("%S+") do
          table.insert(words, word)
        end
        wifi_sw_status = words[5]
        wifi_hw_status = words[6]
      end
    end

    local wifi_blocked = false
    if wifi_sw_status == "blocked" or wifi_hw_status == "blocked" then
      wifi_blocked = true
    end

    local bt_blocked = false
    if bt_sw_status == "blocked" or bt_hw_status == "blocked" then
      bt_blocked = true
    end

    if bt_blocked == true and wifi_blocked == true then
      airplane_icon = "󰀝 "
    end

    widget:set_text(airplane_icon)
  end
)

return M
