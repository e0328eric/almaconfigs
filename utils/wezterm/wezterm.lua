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
	"D2CodingLigature Nerd Font",
	"FiraCode Nerd Font",
	"JetbrainMono Nerd Font",
	"Noto Sans Egyptian Hieroglyphs",
})

config.font_size = 14.0
config.unicode_version = 15

--         ╭──────────────────────────────────────────────────────────╮
--         │                       Colorscheme                        │
--         ╰──────────────────────────────────────────────────────────╯
config.color_scheme = "AyuDark (Gogh)"
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
config.background = {
	{
		source = {
			File = "/Users/almagest/.config/wezterm/Silver_Wolf.png",
		},
		hsb = { brightness = 0.10 },
	},
}

--  ╭──────────────────────────────────────────────────────────╮
--  │                           etc                            │
--  ╰──────────────────────────────────────────────────────────╯
config.native_macos_fullscreen_mode = true
config.front_end = "WebGpu"
-- config.enable_kitty_graphics = true

--         ╭──────────────────────────────────────────────────────────╮
--         │                       Keybindings                        │
--         ╰──────────────────────────────────────────────────────────╯
config.keys = {
	{ key = "w", mods = "CMD|CTRL", action = act.SpawnWindow },
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "CTRL|SHIFT",
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
