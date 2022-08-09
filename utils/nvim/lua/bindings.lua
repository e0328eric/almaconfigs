keymap = vim.keymap.set
local wk = require("which-key")

wk.setup({
	icons = {
		separator = "|",
	},
})

wk.register({
	["<Leader>"] = {
		b = {
			name = "+buffer",
			b = { "<cmd> BufferLinePick <cr>", "Pick a Buffer" },
			c = { "<cmd> BufferLinePickClose <cr>", "Close a picked Buffer" },
			d = { ":bdelete<CR>", "delete buffer" },
		},
		c = {
			name = "+cph",
			c = { "<cmd> CphReceive <cr>", "CphReceive" },
			t = { "<cmd> CphTest <cr>", "CphTest" },
			e = {
				name = "+CphEdit",
				["1"] = { "<cmd> CphEdit1<cr>", "CphEdit" },
				["2"] = { "<cmd> CphEdit2<cr>", "CphEdit" },
				["3"] = { "<cmd> CphEdit3<cr>", "CphEdit" },
				["4"] = { "<cmd> CphEdit4<cr>", "CphEdit" },
				["5"] = { "<cmd> CphEdit5<cr>", "CphEdit" },
				["6"] = { "<cmd> CphEdit6<cr>", "CphEdit" },
				["7"] = { "<cmd> CphEdit7<cr>", "CphEdit" },
				["8"] = { "<cmd> CphEdit8<cr>", "CphEdit" },
				["9"] = { "<cmd> CphEdit9<cr>", "CphEdit" },
			},
		},
		d = {
			name = "+diagnostic",
			d = { "<cmd> TroubleToogle <cr>", "Toggle Diagnostics" },
		},
		e = { "<cmd> NvimTreeToggle<CR>", "open NvimTree" },
		f = {
			name = "+file",
			f = { "<cmd> Telescope find_files <cr>", "Find Files" },
			o = { "<cmd> Telescope oldfiles <cr>", "Open Recent Files " },
		},
		l = {
			name = "+Bracey",
			s = { "<cmd> Bracey <cr>", "Start Bracey" },
			p = { "<cmd> BraceyStop <cr>", "Stop Bracey" },
			r = { "<cmd> BraceyReload <cr>", "Reload Bracey" },
		},
		t = {
			name = "+Terminal",
			o = { "<cmd> ToggleTerm <cr>", "Open Terminal" },
		},
		[" "] = { '<cmd>let @/=""<cr>', "clear search highlights" },
		["/"] = { "<cmd>CommentToggle <cr>", "comment" },
	},
})

-- Bufferline bindings
keymap("n", "<TAB>", "<cmd> BufferLineCycleNext <cr>")
keymap("n", "<S-TAB>", "<cmd> BufferLineCyclePrev <cr>")
keymap("n", "m.", "<cmd> BufferLineMoveNext <cr>")
keymap("n", "m,", "<cmd> BufferLineMovePrev <cr>")

-- Hope bindings
keymap("n", ";j", "<cmd> HopWord <cr>")
keymap("n", ";l", "<cmd> HopLineStart <cr>")

-- Binding for code runner
keymap("n", "<F5>", "<cmd> Run <cr>")

-- Other bindings nvimtree, markdown preview, Neoformat, Colorizer, LazyGit
keymap("n", "[[", "<cmd> vertical resize +7 <cr>")
keymap("n", "]]", "<cmd> vertical resize -7 <cr>")
keymap("n", "+", "<cmd> resize +1 <cr>")
keymap("n", "-", "<cmd> resize -1 <cr>")

-- LSP bindings
keymap("n", "gD", "<cmd> lua vim.lsp.buf.declaration() <cr>")
keymap("n", "gd", "<cmd> lua vim.lsp.buf.definition() <cr>")
keymap("n", "K", "<cmd> lua vim.lsp.buf.hover() <cr>")
keymap("n", "gi", "<cmd> lua vim.lsp.buf.implementation() <cr>")
keymap("n", "<space>wa", "<cmd> lua vim.lsp.buf.add_workspace_folder() <cr>")
keymap("n", "<space>wr", "<cmd> lua vim.lsp.buf.remove_workspace_folder() <cr>")
keymap("n", "<space>wl", "<cmd> lua print(vim.inspect(vim.lsp.buf.list_workspace_folders())) <cr>")
keymap("n", "<space>D", "<cmd> lua vim.lsp.buf.type_definition() <cr>")
keymap("n", "<space>rn", "<cmd> lua vim.lsp.buf.rename() <cr>")
keymap("n", "<space>ca", "<cmd> lua vim.lsp.buf.code_action() <cr>")
keymap("n", "gr", "<cmd> lua vim.lsp.buf.references() <cr>")
keymap("n", "<space>e", "<cmd> lua vim.diagnostic.open_float() <cr>")
keymap("n", "<space>q", "<cmd> lua vim.diagnostic.setloclist() <cr>")
keymap("n", "<space>f", "<cmd> lua vim.lsp.buf.formatting() <cr>")
keymap("n", "<C-k>", "<cmd> lua vim.lsp.buf.signature_help() <cr>")
keymap("n", "<C-n>", "<cmd> lua vim.diagnostic.goto_prev() <cr>")
keymap("n", "<C-p>", "<cmd> lua vim.diagnostic.goto_next() <cr>")

-- Binding to swtich to normal mode in terminal, press <Esc> two times
vim.cmd(":tnoremap <Esc><Esc> <C-\\><C-n>")
