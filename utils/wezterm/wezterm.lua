local os = require("os")
local math = require("math")
local wezterm = require("wezterm")

local act = wezterm.action
local mux = wezterm.mux

-- wezterm.on("gui-startup", function()
-- local tab, pane, window = mux.spawn_window({})
-- window:gui_window():toggle_fullscreen()
-- end)

-- config structure
local config = {}

--         ╭──────────────────────────────────────────────────────────╮
--         │                      Font Settings                       │
--         ╰──────────────────────────────────────────────────────────╯
config.font = wezterm.font_with_fallback({
	"D2CodingLigature",
	"FiraCode Nerd Font",
	"JetbrainMono Nerd Font",
})

config.font_size = 11.0
config.unicode_version = 15
config.warn_about_missing_glyphs = false

--         ╭──────────────────────────────────────────────────────────╮
--         │                       Colorscheme                        │
--         ╰──────────────────────────────────────────────────────────╯
config.color_scheme = "AyuDark (Gogh)"
config.window_frame = {
	font_size = 9.5,
}
config.colors = {
	tab_bar = {
		-- The color of the strip that goes along the top of the window
		-- (does not apply when fancy tab bar is in use)
		background = "#0b0022",
		active_tab = {
			bg_color = "#59c2ff",
			fg_color = "#16161d",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},

		inactive_tab = {
			bg_color = "#9a9bb3",
			fg_color = "#16161d",
		},

		inactive_tab_hover = {
			bg_color = "#98c379",
			fg_color = "#16161d",
			italic = true,
		},

		new_tab = {
			bg_color = "#95e6cb",
			fg_color = "#16161d",
		},

		new_tab_hover = {
			bg_color = "#98c379",
			fg_color = "#16161d",
			italic = true,
		},
	},
}

--         ╭──────────────────────────────────────────────────────────╮
--         │                Window Background Settings                │
--         ╰──────────────────────────────────────────────────────────╯
--[[
config.background = {
	{
		source = {
			File = "/home/almagest/.config/wezterm/silver_wolf.png",
		},
		hsb = { brightness = 0.10 },
	},
}
--]]
config.window_background_opacity = 0.75

--  ╭──────────────────────────────────────────────────────────╮
--  │                           etc                            │
--  ╰──────────────────────────────────────────────────────────╯
-- config.native_macos_fullscreen_mode = true
config.front_end = "WebGpu"
-- config.enable_kitty_graphics = true

--         ╭──────────────────────────────────────────────────────────╮
--         │                       Keybindings                        │
--         ╰──────────────────────────────────────────────────────────╯
config.keys = {
	{ key = "w", mods = "CMD|CTRL", action = act.SpawnWindow },
	{ key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = act.ActivateTab(-1) },
	{
		key = "v",
		mods = "ALT|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "ALT|SHIFT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{ key = "f", mods = "CMD|CTRL", action = wezterm.action.ToggleFullScreen },
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "r",
		mods = "CMD|CTRL",
		action = wezterm.action.ReloadConfiguration,
	},
}

return config
