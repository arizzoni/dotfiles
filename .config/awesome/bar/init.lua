local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local bindings = require("bindings")

local calendar = require("widgets.calendar")
local battery = require("widgets.battery")
local wireless = require("widgets.wireless")

local modkey = bindings.mod.super

local config = function(s)
	-- {{{ Wibar

	-- Create an audio widget
	-- Show mute icon when volume is zero
	-- Show microphone indicator icon
	-- Audio Status               󰕾 󰕿 󰖀 󰝞 󰝟 󰝝 󰖁
	-- Microphone Status          󰍭 󰍬 󰍮 󰍯 󱦉 󱦊

	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
	s.mywireless = wireless
	s.mybattery = battery
	s.mytextclock = wibox.widget.textclock("%I:%M %p", 1)
	s.mycalendar_popup = calendar(s)
	s.mycalendar_popup:attach(s.mytextclock, "tr")
	s.mypromptbox = awful.widget.prompt()

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox({
		screen = s,
		buttons = {
			awful.button({}, 1, function()
				awful.layout.inc(1)
			end),
			awful.button({}, 3, function()
				awful.layout.inc(-1)
			end),
			awful.button({}, 4, function()
				awful.layout.inc(-1)
			end),
			awful.button({}, 5, function()
				awful.layout.inc(1)
			end),
		},
	})

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = {
			awful.button({}, 1, function(t)
				t:view_only()
			end),
			awful.button({ modkey }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
			awful.button({}, 3, awful.tag.viewtoggle),
			awful.button({ modkey }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
			awful.button({}, 4, function(t)
				awful.tag.viewprev(t.screen)
			end),
			awful.button({}, 5, function(t)
				awful.tag.viewnext(t.screen)
			end),
		},
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = {
			awful.button({}, 1, function(c)
				c:activate({ context = "tasklist", action = "toggle_minimization" })
			end),
			awful.button({}, 3, function()
				awful.menu.client_list({ theme = { width = 250 } })
			end),
			awful.button({}, 4, function()
				awful.client.focus.byidx(-1)
			end),
			awful.button({}, 5, function()
				awful.client.focus.byidx(1)
			end),
		},
	})

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		restrict_workarea = true,
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, beautiful.corner_radius)
		end,
		screen = s,
		height = 32,
		opacity = beautiful.tooltip_opacity,
		widget = {
			layout = wibox.layout.align.horizontal,
			{ -- Left widgets
				layout = wibox.layout.fixed.horizontal,
				s.mylayoutbox,
				s.mytaglist,
				s.mypromptbox,
			},
			s.mytasklist, -- Middle widgets
			{ -- Right widgets
				layout = wibox.layout.fixed.horizontal,
				wibox.widget.systray(),
				s.mywireless,
				s.mybattery,
				s.mytextclock,
			},
		},
	})
end

return config
