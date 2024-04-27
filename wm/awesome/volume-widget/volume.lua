local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

local volume_widget = {}

local function worker(user_args)
	return volume_widget
end

return setmetatable(volume_widget, {
	__call = function(_, ...)
		return worker(...)
	end,
})
