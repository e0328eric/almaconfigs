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
local keys = {}
local launch_menu = {}

--         ╭──────────────────────────────────────────────────────────╮
--         │                      Font Settings                       │
--         ╰──────────────────────────────────────────────────────────╯
config.font = wezterm.font_with_fallback({
	"D2CodingLigature Nerd Font Mono",
	"FiraCode Nerd Font",
	"JetbrainMono Nerd Font",
})

config.font_size = 11
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
config.window_background_opacity = 0.84

--  ╭──────────────────────────────────────────────────────────╮
--  │                           etc                            │
--  ╰──────────────────────────────────────────────────────────╯
-- config.native_macos_fullscreen_mode = true
-- config.front_end = "WebGpu"
-- config.enable_kitty_graphics = true

-- I shall use UCRT64 in default.
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = {
		"C:/msys64/msys2_shell.cmd",
		"-defterm",
		"-where",
		"C:/msys64/home/almag",
		"-no-start",
		"-ucrt64",
		"-shell",
		"fish",
	}

	table.insert(launch_menu, {
		label = "UCRT64",
		args = {
			"C:/msys64/msys2_shell.cmd",
			"-defterm",
			"-where",
			"C:/msys64/home/almag",
			"-no-start",
			"-ucrt64",
			"-shell",
			"fish",
		},
	})
	table.insert(launch_menu, {
		label = "Wsl - Arch",
		args = { "wsl.exe", "-u", "almagest" },
	})
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})
end

--         ╭──────────────────────────────────────────────────────────╮
--         │                       Keybindings                        │
--         ╰──────────────────────────────────────────────────────────╯
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	keys = {
		{ key = "t", mods = "CTRL|ALT", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "1", mods = "CTRL|ALT", action = act.ActivateTab(0) },
		{ key = "2", mods = "CTRL|ALT", action = act.ActivateTab(1) },
		{ key = "3", mods = "CTRL|ALT", action = act.ActivateTab(2) },
		{ key = "4", mods = "CTRL|ALT", action = act.ActivateTab(3) },
		{ key = "5", mods = "CTRL|ALT", action = act.ActivateTab(4) },
		{ key = "6", mods = "CTRL|ALT", action = act.ActivateTab(5) },
		{ key = "7", mods = "CTRL|ALT", action = act.ActivateTab(6) },
		{ key = "8", mods = "CTRL|ALT", action = act.ActivateTab(7) },
		{ key = "9", mods = "CTRL|ALT", action = act.ActivateTab(-1) },
		{
			key = "d",
			mods = "CTRL|SHIFT",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "s",
			mods = "CTRL|SHIFT",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{ key = "l", mods = "CTRL|SHIFT", action = act.ShowLauncher },
		{ key = "f", mods = "CTRL|ALT", action = act.ToggleFullScreen },
		{ key = "Enter", mods = "ALT", action = act.DisableDefaultAssignment },
		{ key = "r", mods = "CTRL|ALT", action = act.ReloadConfiguration },
		{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
		{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
		{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	}
else
	keys = {
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
		{ key = "f", mods = "CMD|CTRL", action = act.ToggleFullScreen },
		{ key = "Enter", mods = "ALT", action = act.DisableDefaultAssignment },
		{ key = "r", mods = "CMD|CTRL", action = act.ReloadConfiguration },
		{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
		{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
		{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	}
end

config.disable_default_key_bindings = true
config.keys = keys
config.launch_menu = launch_menu

return config
