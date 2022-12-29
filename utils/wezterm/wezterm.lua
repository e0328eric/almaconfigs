local wezterm = require("wezterm")
local act = wezterm.action

return {
	--         ╭──────────────────────────────────────────────────────────╮
	--         │                      Font Settings                       │
	--         ╰──────────────────────────────────────────────────────────╯
	font = wezterm.font_with_fallback({ "FiraCode Nerd Font", "JetbrainMono Nerd Font" }),
	font_size = 12.0,

	--         ╭──────────────────────────────────────────────────────────╮
	--         │                       Colorscheme                        │
	--         ╰──────────────────────────────────────────────────────────╯
	color_scheme = "AyuDark (Gogh)",

	--         ╭──────────────────────────────────────────────────────────╮
	--         │                Window Background Settings                │
	--         ╰──────────────────────────────────────────────────────────╯
	window_background_image = "/Users/almagest/.config/wezterm/Shirakami_Fubuki2.jpg",
	window_background_image_hsb = { brightness = 0.07 },

	--         ╭──────────────────────────────────────────────────────────╮
	--         │                       Keybindings                        │
	--         ╰──────────────────────────────────────────────────────────╯
	keys = {
		{ key = "w", mods = "CMD|CTRL", action = act.SpawnWindow },
		{ key = "v", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "s", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	},
}
