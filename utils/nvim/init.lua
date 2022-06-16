local fn = vim.fn
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = " "

-- bootstrap 'packer' package for neovim
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

require("packer").startup(function(use)
	-- Packer Package
	use("wbthomason/packer.nvim")

	-- Theme Relateed Packages
	use("vim-airline/vim-airline")
	use("vim-airline/vim-airline-themes")
	use("chriskempson/base16-vim")

	-- Languages
	use("mhartington/formatter.nvim")
	use({ "fatih/vim-go", run = ":GoUpdateBinaries" })
	use("ziglang/zig.vim")
	use("rust-lang/rust.vim")
	use("mhinz/vim-crates")
	use("dense-analysis/ale")
	use("simrat39/rust-tools.nvim")
	use("luochen1990/rainbow")
	use("bfrg/vim-cpp-modern")

	-- autocompletion
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")

	-- ultisnips
	use("SirVer/ultisnips")
	use("quangnguyen30192/cmp-nvim-ultisnips")

	-- which-keys
	use("folke/which-key.nvim")

	-- telescope
	use({ "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" })

	-- Miscellaneous
	use({ "mg979/vim-visual-multi", branch = "master" })
	use("antoyo/vim-licenses")
	use("ggandor/lightspeed.nvim")
	use("terrortylor/nvim-comment")
	use("voldikss/vim-floaterm")
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		tag = "master", -- optional, updated every week. (see issue #1193)
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

--------------------------------------------------
--  Basic Setting
--------------------------------------------------
cmd("syntax enable")
cmd("set autoindent")
cmd("set background=dark")
cmd("set clipboard=unnamedplus")
cmd("set cmdheight=2")
cmd("set conceallevel=0")
cmd("set cursorline")
cmd("set encoding=utf-8")
cmd("set expandtab")
cmd("set fileencoding=utf-8")
cmd("set formatoptions-=cro")
cmd("set guifont=Fira\\ Code\\ Nerd\\ Font")
cmd("set hidden")
cmd("set incsearch")
--cmd("set iskeyword+=-")
cmd("set laststatus=3")
cmd("set mouse=n")
cmd("set nobackup")
cmd("set noshowmode")
cmd("set nowrap")
cmd("set nowritebackup")
cmd("set nu rnu")
cmd("set pumheight=10")
cmd("set ruler")
cmd("set scrolloff=3")
cmd("set shiftwidth=4")
cmd("set shortmess+=c")
cmd("set showtabline=2")
cmd("set signcolumn=yes")
cmd("set smartindent")
cmd("set smarttab")
cmd("set splitbelow")
cmd("set splitright")
cmd("set t_Co=256")
cmd("set tabstop=4")
cmd("set termguicolors")
cmd("set timeoutlen=100")
cmd("set updatetime=300")

-- transparent neovim
--cmd("au ColorScheme * hi Normal ctermbg=none guibg=none")

-- import filetypes
cmd("autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o")
cmd("au BufRead,BufNewFile *.ves set filetype=vesti")
cmd([[
filetype plugin indent on

augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END

if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif
]])

--------------------------------------------------
--  Theme Setting
--------------------------------------------------
cmd("let base16colorspace=256")
cmd("set termguicolors")
cmd("colorscheme base16-eighties")

--------------------------------------------------
--  Keybindings (Basic)
--------------------------------------------------
-- mapping keymaps helper function
function keybind(mode, key, mapsto, is_noremap)
	vim.keymap.set(mode, key, mapsto, { noremap = is_noremap })
end

-- Better Indenting
keybind("v", "<", "<gv", false)
keybind("v", ">", ">gv", false)

-- TAB in general mode will move to next buffer
keybind("n", "<TAB>", ":bnext<CR>", false)
keybind("n", "<S-TAB>", ":bprevious<CR>", false)

-- Move selected line / block of text in visual mode
-- shift + k to move up
-- shift + j to move down
keybind("x", "K", ":move '<-2<CR>gv-gv", false)
keybind("x", "J", ":move '>+1<CR>gv-gv", false)

keybind("n", "<C-\\>", "O", false)
keybind("i", "<C-\\>", "<C-[>O", false)

-- remap Q to other one
keybind("n", "Q", "gq", false)

--------------------------------------------------
--  Keybindings (which-key)
--------------------------------------------------
local wk = require("which-key")

wk.setup({
	icons = {
		separator = "|",
	},
})
wk.register({
	["<leader>"] = {
		b = {
			name = "+buffer",
			["1"] = { ":b1<CR>", "buffer 1" },
			["2"] = { ":b2<CR>", "buffer 2" },
			["3"] = { ":b3<CR>", "buffer 3" },
			["4"] = { ":b4<CR>", "buffer 4" },
			["5"] = { ":b5<CR>", "buffer 5" },
			["?"] = { ":Telescope buffers<CR>", "show all buffers" },
			d = { ":bdelete<CR>", "delete buffer" },
			f = { ":bfirst<CR>", "first-buffer" },
			h = { ":Startify<CR>", "home-buffer" },
			l = { ":blast<CR>", "last-buffer" },
			n = { ":bnext<CR>", "next-buffer" },
			p = { ":bprevious<CR>", "previous-buffer" },
		},
		[" "] = { ':let @/=""<CR>', "clear search highlights" },
		e = { ":NvimTreeToggle<CR>", "open NvimTree" },
		f = {
			name = "+file",
			f = { ":Telescope find_files<CR>", "Find File" },
			r = { ":Telescope oldfiles<CR>", "Open Recent File" },
			n = { ":enew<CR>", "New File" },
			t = {
				name = "+NvimTree",
				t = { ":NvimTreeToggle<CR>", "open NvimTree" },
				r = { ":NvimTreeRefresh<CR>", "refresh NvimTree" },
			},
		},
		t = {
			name = "+terminal",
			g = { ":FloatermNew --height=38 lazygit<CR>", "lazygit" },
			t = { ":FloatermNew --wintype=popup<CR>", "open a floating terminal" },
			p = { ":FloatermNew python<CR>", "python" },
		},
	},
})
--------------------------------------------------
--  Formatter
--------------------------------------------------
require("formatter").setup({
	filetype = {
		c = {
			function()
				return {
					exe = "clang-format",
					stdin = true,
				}
			end,
		},
		cpp = {
			function()
				return {
					exe = "clang-format",
					stdin = true,
				}
			end,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		rust = {
			function()
				return {
					exe = "rustfmt",
					stdin = true,
				}
			end,
		},
	},
})
cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]])

--------------------------------------------------
--  Ultisnips
--------------------------------------------------
g.UltiSnipsExpandTrigger = "<TAB>"
g.UltiSnipsJumpForwardTrigger = "<TAB>"
g.UltiSnipsJumpBackwardTrigger = "<S-TAB>"
g.UltiSnipsUsePythonVersion = 3

g.UltiSnipsSnippetDirectories = { "~/.config/nvim/snips" }

g.python_highlight_all = 1

--------------------------------------------------
--  nvim-comment
--------------------------------------------------
require("nvim_comment").setup({
	line_mapping = "<leader>/.",
	operator_mapping = "<leader>//",
})

--------------------------------------------------
--  ale
--------------------------------------------------
g.ale_sign_error = "!!"
g.ale_sign_warning = "<>"
g.ale_linters = { asm = {}, nasm = {}, tex = {}, plaintex = {} }
keybind("n", "K", ":ALEGoToDefinition<CR>", false)

--------------------------------------------------
--  nvim-tree
--------------------------------------------------
require("nvim-tree").setup({
	view = {
		mappings = {
			list = { -- Default Mapping of nvim-tree
				{ key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
				{ key = "<C-e>", action = "edit_in_place" },
				{ key = "O", action = "edit_no_picker" },
				{ key = { "<C-]>", "<2-RightMouse>" }, action = "cd" },
				{ key = "<C-v>", action = "vsplit" },
				{ key = "<C-x>", action = "split" },
				{ key = "<C-t>", action = "tabnew" },
				{ key = "<", action = "prev_sibling" },
				{ key = ">", action = "next_sibling" },
				{ key = "P", action = "parent_node" },
				{ key = "<BS>", action = "close_node" },
				{ key = "<Tab>", action = "preview" },
				{ key = "K", action = "first_sibling" },
				{ key = "J", action = "last_sibling" },
				{ key = "I", action = "toggle_git_ignored" },
				{ key = "H", action = "toggle_dotfiles" },
				{ key = "U", action = "toggle_custom" },
				{ key = "R", action = "refresh" },
				{ key = "a", action = "create" },
				{ key = "d", action = "remove" },
				{ key = "D", action = "trash" },
				{ key = "r", action = "rename" },
				{ key = "<C-r>", action = "full_rename" },
				{ key = "x", action = "cut" },
				{ key = "c", action = "copy" },
				{ key = "p", action = "paste" },
				{ key = "y", action = "copy_name" },
				{ key = "Y", action = "copy_path" },
				{ key = "gy", action = "copy_absolute_path" },
				{ key = "[c", action = "prev_git_item" },
				{ key = "]c", action = "next_git_item" },
				{ key = "-", action = "dir_up" },
				{ key = "s", action = "system_open" },
				{ key = "f", action = "live_filter" },
				{ key = "F", action = "clear_live_filter" },
				{ key = "q", action = "close" },
				{ key = "W", action = "collapse_all" },
				{ key = "E", action = "expand_all" },
				{ key = "S", action = "search_node" },
				{ key = ".", action = "run_file_command" },
				{ key = "<C-k>", action = "toggle_file_info" },
				{ key = "g?", action = "toggle_help" },
			},
		}, -- END OF MAPPING
	},
})

--------------------------------------------------
--  rust-config
--------------------------------------------------
local nvim_lsp = require("lspconfig")

local rust_conf_opts = {
	tools = { -- rust-tools options
		autoSetHints = true,
		hover_with_actions = true,
		inlay_hints = {
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},

	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
	server = {
		-- on_attach is a callback called when the language server attachs to the buffer
		-- on_attach = on_attach,
		settings = {
			-- to enable rust-analyzer settings visit:
			-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
			["rust-analyzer"] = {
				-- enable clippy on save
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
}

require("rust-tools").setup(rust_conf_opts)

--------------------------------------------------
--  nvim-cmp
--------------------------------------------------
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-}>"] = cmp.mapping.select_prev_item(),
		["<C-]>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-c>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "ultisnips" },
	}, {
		{ name = "buffer" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
