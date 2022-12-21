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

vim.keymap.set("v", "J", ":m >+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m <-2<CR>gv=gv")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<S-Up>", "<nop>")
vim.keymap.set("n", "<S-Down>", "<nop>")
