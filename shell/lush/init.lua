-- Lush configuration. This file is created once and is yours to edit.
-- It is ordinary Lua, loaded before the prompt, scripts, and -c commands.

-- Keep the built-in prompt, or uncomment this to customize it:
-- lush.config.prompt = function() return pwd() .. " > " end

lush.config.history_limit = 1000
lush.config.autosuggestions = true -- Right Arrow accepts a suggestion.
lush.config.syntax_highlighting = true -- Color Lua input at the prompt

-- History defaults to history.jsonl beside this file. An unset history_file
-- permits the LUSH_HISTORY_FILE environment override.
-- lush.config.history_file = false  -- Keep session history without saving.
-- lush.config.history_file = "path/to/history.jsonl"

-- Theme files are loaded on demand when selected by name.
-- Only themes/<name>.lua is loaded; unselected theme files are not executed.
-- Selected themes run in a restricted Lua state; init.lua keeps normal shell access.
lush.config.themes = lush.config.themes or {}

lush.config.theme = "easy-term" -- "easy-term", "iterm2", or nil for plain
lush.config.theme_options = { icons = true, git = true, time = true }

-- Personal Lua aliases.
do
	local aliases_file = path.join(lush.config_dir, "aliases.lua")
	if exists(aliases_file) then
		source(aliases_file)
	end
end
