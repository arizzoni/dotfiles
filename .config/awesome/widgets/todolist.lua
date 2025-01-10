-- Create a mail monitor widget

-- # unread messages/# messages in mailbox

local wibox = require("wibox")
local beautiful = require("beautiful")

-- see if the file exists
function file_exists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function lines_from(file)
	if not file_exists(file) then
		return {}
	end
	local lines = {}
	for line in io.lines(file) do
		lines[#lines + 1] = line
	end
	return lines
end

-- tests the functions above
local todofile = "/home/air/todo.txt"
local text = table.concat(lines_from(todofile), "\n")

local box = wibox.wibox({
	ontop = true,
	type = "desktop",
	input_passthrough = true,
	fg = beautiful.fg_urgent,
	bg = nil,
})

box.widget({
	text = text,
	widget = wibox.widget.textbox,
})

return box
