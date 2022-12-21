local wk = require("which-key")

vim.g.mapleader = " "

wk.register({
	[" "] = {
		function()
			vim.cmd([[let @/=""]])
		end,
		"Clear search highlights",
	},
	b = {
		name = "+buffer",
		d = { ":bdelete<CR>", "delete buffer" },
	},
	e = { vim.cmd.NvimTreeToggle, "Open default neovim Ex" },
}, { prefix = "<leader>" })
