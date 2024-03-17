local gears = require("gears")
local awful = require("awful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local modkey = require("settings.constants").modkey
local terminal = require("settings.constants").terminal
local browser = require("settings.constants").browser

local globalkeys = gears.table.join(
	awful.key({ modkey, "Shift" }, "/", hotkeys_popup.show_help, {
		description = "show help",
		group = "awesome",
	}),
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, {
		description = "view next",
		group = "tag",
	}),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	awful.key({ modkey }, "Tab", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ "Mod1" }, "Tab", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "Tab", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ "Mod1", "Shift" }, "Tab", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, {
		description = "jump to urgent client",
		group = "client",
	}),
	awful.key({ modkey, "Shift", "Control" }, "p", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }), -- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Shift" }, "Return", function()
		awful.spawn(browser)
	end, {
		description = "open a browser",
		group = "launcher",
	}),

	-- reload awesome configuration file
	awful.key({ modkey, "Shift" }, "r", awesome.restart, {
		description = "reload awesome",
		group = "awesome",
	}),

	-- system poweroff, reboot asnd awesome session close
	awful.key({ modkey, "Shift", "Control" }, "x", awesome.quit, { description = "quit awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "x", function()
		awful.spawn('check-twice.sh "Are you sure you want to lock?" "light-locker-command -l"')
	end, { description = "lock the computer", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "c", function()
		awful.spawn('check-twice.sh "Are you sure you want to shutdown?" "poweroff"')
	end, { description = "power off the computer", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "v", function()
		awful.spawn('check-twice.sh "Are you sure you want to reboot?" "reboot"')
	end, { description = "reboot the computer", group = "awesome" }),

	-- rofi file browser popup
	awful.key({ modkey, "Ctrl" }, "s", function()
		awful.spawn("rofi-filebrowser.sh")
	end, { description = "open rofi file browser", group = "spawn" }),

	-- moving floating windows to
	awful.key({ modkey, "Mod1" }, "q", function()
		awful.placement.align(client.focus, { position = "top_left" })
	end, { description = "move floating window to the top left", group = "floating movement" }),
	awful.key({ modkey, "Mod1" }, "w", function()
		awful.placement.align(client.focus, { position = "top" })
	end, { description = "move floating window to the top", group = "floating movement" }),
	awful.key({ modkey, "Mod1" }, "e", function()
		awful.placement.align(client.focus, { position = "top_right" })
	end, { description = "move floating window to the top right", group = "floating movement" }),
	awful.key({ modkey, "Mod1" }, "a", function()
		awful.placement.align(client.focus, { position = "left" })
	end, { description = "move floating window to the left", group = "floating movement" }),
	awful.key({ modkey, "Mod1" }, "s", function()
		awful.placement.align(client.focus, { position = "centered" })
	end, { description = "move floating window to the center", group = "floating movement" }),
	awful.key({ modkey, "Mod1" }, "d", function()
		awful.placement.align(client.focus, { position = "right" })
	end, { description = "move floating window to the right", group = "floating movement" }),
	awful.key({ modkey, "Mod1" }, "z", function()
		awful.placement.align(client.focus, { position = "bottom_left" })
	end, { description = "move floating window to the bottom left", group = "floating movement" }),
	awful.key({ modkey, "Mod1" }, "x", function()
		awful.placement.align(client.focus, { position = "bottom" })
	end, { description = "move floating window to the bottom", group = "floating movement" }),
	awful.key({ modkey, "Mod1" }, "c", function()
		awful.placement.align(client.focus, { position = "bottom_right" })
	end, { description = "move floating window to the bottom right", group = "floating movement" }),

	awful.key({ modkey }, "k", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "j", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "j", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "j", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, {
		description = "select next",
		group = "layout",
	}),
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }), -- Prompt
	awful.key({ "Mod1", "Control" }, "d", function()
		awful.screen.focused().mypromptbox:run()
	end, { description = "run prompt", group = "launcher" }),

	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn("volume_brightness.sh volume_up")
	end, { description = "volume up", group = "awesome" }),
	awful.key({ modkey, "Shift", "Control" }, "Up", function()
		awful.spawn("volume_brightness.sh volume_up")
	end, { description = "volume up", group = "awesome" }),
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn("volume_brightness.sh volume_down")
	end, { description = "volume down", group = "awesome" }),
	awful.key({ modkey, "Shift", "Control" }, "Down", function()
		awful.spawn("volume_brightness.sh volume_down")
	end, { description = "volume down", group = "awesome" }),
	awful.key({}, "XF86AudioMute", function()
		awful.spawn("volume_brightness.sh volume_mute")
	end, { description = "volume mute", group = "awesome" }),
	awful.key({ modkey, "Shift", "Control" }, "m", function()
		awful.spawn("volume_brightness.sh volume_mute")
	end, { description = "volume mute", group = "awesome" }),

	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn("volume_brightness.sh brightness_up")
	end, { description = "backlight brightness up", group = "awesome" }),
	awful.key({ modkey, "Shift", "Control" }, "Right", function()
		awful.spawn("volume_brightness.sh brightness_up")
	end, { description = "backlight brightness up", group = "awesome" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn("volume_brightness.sh brightness_down")
	end, { description = "backlight brightness down", group = "awesome" }),
	awful.key({ modkey, "Shift", "Control" }, "Left", function()
		awful.spawn("volume_brightness.sh brightness_down")
	end, { description = "backlight brightness down", group = "awesome" }),
	awful.key({ "Shift" }, "XF86MonBrightnessUp", function()
		awful.spawn("volume_brightness.sh brightness_up_less")
	end, { description = "backlight brightness up less", group = "awesome" }),
	awful.key({ "Shift" }, "XF86MonBrightnessDown", function()
		awful.spawn("volume_brightness.sh brightness_down_less")
	end, { description = "backlight brightness down less", group = "awesome" }),

	-- awful.key({ modkey }, "x",
	-- function ()
	-- awful.prompt.run {
	-- prompt       = "Run Lua code: ",
	-- textbox      = awful.screen.focused().mypromptbox.widget,
	-- exe_callback = awful.util.eval,
	-- history_path = awful.util.get_cache_dir() .. "/history_eval"
	-- }
	-- end,
	-- {description = "lua execute prompt", group = "awesome"}),
	-- Menubar
	awful.key({ modkey, "Control" }, "d", function()
		menubar.show()
	end, {
		description = "show the menubar",
		group = "launcher",
	})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 10.
for i = 1, 10 do
	globalkeys = gears.table.join(
		globalkeys, -- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		--awful.key({ modkey, "Control" }, "#" .. i + 9, function()
		--local screen = awful.screen.focused()
		--local tag = screen.tags[i]
		--if tag then
		--awful.tag.viewtoggle(tag)
		--end
		--end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

-- Set keys
root.keys(globalkeys)
