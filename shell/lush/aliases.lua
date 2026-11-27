-- Personal aliases: ordinary trusted Lua, loaded by init.lua.
-- Call aliases using Lua syntax: v('notes.txt'), l(), vimconfig().
-- External aliases return lazy command plans, like cmd.nvim(...).
-- Use run(v('notes.txt')) in a script; at the prompt the result runs directly.
-- Copy text with a pipeline: 'hello' | pbcopy().

alias({
	v = { "nvim" },
	h = { "hx" },
	l = function(...)
		return ls("-al", ...)
	end,
	lg = { "lazygit" },
	dyt = { "yt-dlp" },
	getmusic = { "yt-dlp", "-x", "--audio-format", "m4a" },
	pbcopy = { "win32yank.exe", "-i" },
	archlinux = { "wsl.exe", "-d", "archlinux", "--cd", "~", "-u", "almagest" },

	hakwon = function()
		cd("C:/Users/almag/pCloud/TeX_Documents/Hakwon")
	end,
	minireport = function()
		cd("C:/Users/almag/pCloud/TeX_Documents/Mini_Report")
	end,
	notetaking = function()
		cd("C:/Users/almag/pCloud/TeX_Documents/NoteTaking")
	end,
	homework = function()
		cd("C:/Users/almag/pCloud/TeX_Documents/Homework")
	end,
	teachingf = function()
		cd("C:/Users/almag/pCloud/TeX_Documents/TF")
	end,
	seminar = function()
		cd("C:/Users/almag/pCloud/TeX_Documents/Seminar")
	end,
	papers = function()
		cd("C:/Users/almag/pCloud/TeX_Documents/Papers")
	end,
	kindergarten = function()
		cd("C:/Users/almag/pCloud/TeX_Documents/Kindergarten")
	end,
	vimconfig = function()
		cd("C:/Users/almag/AppData/Local/nvim")
	end,
})
