local M = {}

local awful = require("awful")
local util = require("util")

-- Create a wireless widget
-- 󰂯 󰂰 󰂱 󰂲 󰂳 󰂴
-- 󰤯 󰤟 󰤢 󰤥 󰤨
-- 󰤫 󰤠 󰤣 󰤦 󰤩
-- 󰤬 󰤡 󰤤 󰤧 󰤪
-- 󰤮 󰤭

M.mywireless = awful.widget.watch("iwconfig", 1,
  function(widget, stdout)
    local wireless_icon = ""
    local essid = ""
    local link_quality_string = ""
    local link_quality_float = nil

    for line in stdout:gmatch("[^\r\n]+") do
      if line:match("ESSID") then
        local words = {}
        for word in line:gmatch("%S+") do
          table.insert(words, word)
        end
        essid = string.match(words[4], [[ESSID:"([^"]+)]])
      end
      if line:match("Quality") then
        local words = {}
        for word in line:gmatch("%S+") do
          table.insert(words, word)
        end
        link_quality_string = string.match(words[2], [[Quality=([^ ]+)]])
        local numerator = util.split(link_quality_string, "/")[1]
        local denominator = util.split(link_quality_string, "/")[2]
        link_quality_float = 100 * tonumber(numerator) / tonumber(denominator)
      end
    end

    if link_quality_float <= 100 and link_quality_float > 80 then
      wireless_icon = "󰤨 "
    elseif link_quality_float <= 80 and link_quality_float > 60 then
      wireless_icon = "󰤥 "
    elseif link_quality_float <= 60 and link_quality_float > 40 then
      wireless_icon = "󰤢 "
    elseif link_quality_float <= 40 and link_quality_float > 20 then
      wireless_icon = "󰤟 "
    elseif link_quality_float <= 20 and link_quality_float > 0 then
      wireless_icon = "󰤯 "
    end

    widget:set_text(" " .. essid .. " " .. wireless_icon .. " ")
  end
)

return M
