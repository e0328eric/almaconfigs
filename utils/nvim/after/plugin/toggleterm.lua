local toggleterm = require("toggleterm")

toggleterm.setup({
	size = 20,
	open_mapping = "<S-C-t>",
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
	},
})
