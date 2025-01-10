local awful = require("awful")
-- local wibox = require("wibox")
local beautiful = require("beautiful")
-- local gears = require("gears")

local Prompt = {}

Prompt.prompt = nil
Prompt.bg = nil
Prompt.fg = nil
Prompt.fg_cursor = nil
Prompt.bg_cursor = nil
Prompt.ul_cursor = nil
Prompt.font = nil
Prompt.highlighter = nil
Prompt.exe_callback = nil
Prompt.with_shell = nil
Prompt.completion_callback = nil
Prompt.history_path = nil
Prompt.history_max = nil
Prompt.done_callback = nil
Prompt.changed_callback = nil
Prompt.keypressed_callback = nil
Prompt.keyreleased_callback = nil
Prompt.hooks = nil

function Prompt.new(opts)
	local self = setmetatable({}, Prompt)

	self.prompt = opts.prompt or ":"
	self.bg = opts.bg or beautiful.bg_normal
	self.fg = opts.fg or beautiful.fg_normal
	self.fg_cursor = opts.fg_cursor or beautiful.bg_normal
	self.bg_cursor = opts.bg_cursor or beautiful.fg_normal
	self.ul_cursor = opts.ul_cursor or beautiful.bg_normal
	self.font = opts.font or beautiful.prompt_font
	self.highlighter = opts.highlighter or nil
	self.exe_callback = opts.exe_callback or nil
	self.with_shell = opts.with_shell or true
	self.completion_callback = opts.completion_callback or nil
	self.history_path = opts.history_path or nil
	self.history_max = opts.history_max or nil
	self.done_callback = opts.done_callback or nil
	self.changed_callback = opts.changed_callback or nil
	self.keypressed_callback = opts.keypressed_callback or nil
	self.keyreleased_callback = opts.keyreleased_callback or nil
	self.hooks = opts.hooks or {}

	self.widget = awful.widget.prompt({
		prompt = self.prompt,
		bg = self.bg,
		fg = self.fg,
		fg_cursor = self.fg_cursor,
		bg_cursor = self.bg_cursor,
		ul_cursor = self.ul_cursor,
		font = self.font,
		highlighter = self.highlighter,
		exe_callback = self.exe_callback,
		with_shell = self.with_shell,
		completion_callback = self.completion_callback,
		history_path = self.history_path,
		history_max = self.history_max,
		done_callback = self.done_callback,
		changed_callback = self.changed_callback,
		keypressed_callback = self.keypressed_callback,
		keyreleased_callback = self.keyreleased_callback,
		hooks = self.hooks,
	})

	return self
end

function Prompt:run()
	self.widget:run()
end

return Prompt
