local awful = require("awful")

awful.mouse.append_global_mousebindings({
	awful.button({}, 3, function()
		require("menu.mainmenu"):toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev),
})
