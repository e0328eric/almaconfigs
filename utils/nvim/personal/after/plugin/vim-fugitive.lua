local wk = require("which-key")

wk.register({
	g = {
		name = "+git",
		s = { vim.cmd.Git, "Open Git" },
	},
}, { prefix = "<leader>" })
