local wk = require("which-key")

wk.register({
	u = { vim.cmd.UndotreeToggle, "Toggle the undotree" },
}, { prefix = "<leader>" })
