return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- apperative plugins
	use("hrsh7th/vim-vsnip")
	use("glepnir/dashboard-nvim")
	-- use 'marko-cerovac/material.nvim'
	use("RRethy/nvim-base16")
	use("vv9k/bogster")
	use("andweeb/presence.nvim")

	use("jceb/vim-orgmode")
	use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
	use("alaviss/nim.nvim")

	-- functional plugins
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/nvim-cmp")
	use("williamboman/nvim-lsp-installer")
	use("mfussenegger/nvim-jdtls")
	use("onsails/lspkind-nvim")
	use("e0328eric/vesti-vim")
	use("akinsho/nvim-toggleterm.lua")
	use("norcalli/nvim-colorizer.lua")
	use("kdheepak/lazygit.nvim")
	use("SirVer/ultisnips")
	use("folke/which-key.nvim")
	use("b3nj5m1n/kommentary")
	use("mhinz/vim-crates")
	use({ "turbio/bracey.vim", run = "cd app & npm install --prefix server" })
	use("sbdchd/neoformat")
	use({
		"ur4ltz/surround.nvim",
		config = function()
			require("surround").setup({ mappings_style = "surround" })
		end,
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	use({
		"mg979/vim-visual-multi",
		branch = "master",
	})

	use({
		"phaazon/hop.nvim",
		as = "hop",
	})

	use({
		"akinsho/nvim-bufferline.lua",
		requires = "kyazdani42/nvim-web-devicons",
	})

	use({
		"p00f/cphelper.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"ygm2/rooter.nvim",
			opt = true,
		},
	})

	use({
		"hoob3rt/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
		},
	})

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})

	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
	})

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})

	use_rocks({ "lunajson" })
end)
