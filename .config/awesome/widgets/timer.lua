local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Initialize the variables
local countdown_time = 0 -- The time entered by the user
local remaining_time = 0 -- Time remaining for the countdown
local countdown_timer = nil -- Timer object

-- Create the progress bar
local progress_bar = wibox.widget({
	max_value = 1,
	value = 0,
	forced_height = 20,
	color = beautiful.fg_focus,
	background_color = beautiful.bg_focus,
	widget = wibox.widget.progressbar,
})

-- Function to start the countdown
local function start_countdown(time_seconds)
	countdown_time = time_seconds
	remaining_time = time_seconds

	-- Update the progress bar
	progress_bar.max_value = countdown_time
	progress_bar.value = remaining_time

	-- Start the timer that updates every second
	if countdown_timer then
		countdown_timer:stop()
	end

	countdown_timer = gears.timer({
		timeout = 1,
		autostart = true,
		callback = function()
			remaining_time = remaining_time - 1
			progress_bar.value = remaining_time

			-- If time is up, stop the timer and show a notification
			if remaining_time <= 0 then
				countdown_timer:stop()
				naughty.notify({
					title = "Countdown Complete",
					text = "The countdown has finished!",
					timeout = 5,
				})
			end
		end,
	})
end

-- Create a prompt widget to enter the countdown time
local prompt = awful.widget.prompt({
	prompt = "Set countdown time (seconds): ",
	textbox = awful.screen.focused().mypromptbox.widget,
})

-- When the user submits the input, start the countdown
prompt:connect_signal("submit", function(_, input)
	local time_seconds = tonumber(input)
	if time_seconds then
		start_countdown(time_seconds)
	else
		naughty.notify({
			title = "Invalid Input",
			text = "Please enter a valid number.",
			timeout = 5,
		})
	end
end)

-- Layout for the countdown widget
local countdown_widget = wibox.widget({
	layout = wibox.layout.align.horizontal,
	prompt,
	progress_bar,
})

-- You can add the countdown_widget to your wibox
awful.screen.focused().wibox:setup({
	layout = wibox.layout.align.horizontal,
	{ -- Left widget
		countdown_widget,
		widget = wibox.container.margin,
		margins = 10,
	},
})
