local lsp = require("lsp-zero")
local cmp = require("cmp")

lsp.preset("recommended")

lsp.ensure_installed({
	"sumneko_lua",
	"rust_analyzer",
})

lsp.set_preferences({
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-]>"] = cmp.mapping.select_next_item(cmp_select),
	["<A-]>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
	["<Tab>"] = cmp.mapping({
		c = function()
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
			else
				cmp.complete()
			end
		end,
		i = function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
			elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
				vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
			else
				fallback()
			end
		end,
		s = function(fallback)
			if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
				vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
			else
				fallback()
			end
		end,
	}),
	["<S-Tab>"] = cmp.mapping({
		c = function()
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
			else
				cmp.complete()
			end
		end,
		i = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
			elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
				return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
			else
				fallback()
			end
		end,
		s = function(fallback)
			if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
				return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
			else
				fallback()
			end
		end,
	}),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.on_attach(function(client, bufnr)
	local opts = function(desc)
		if desc == nil then
			return { buffer = bufnr, remap = false }
		else
			return { desc = desc, buffer = bufnr, remap = false }
		end
	end

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts("Goto definition"))
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts())
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts("Workspace Symbol"))
	vim.keymap.set("n", "gl", function()
		vim.diagnostic.open_float()
	end, opts("Open diagnostic with floating window"))
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts("Diagnostic goto next"))
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts("Diagnostic goto previous"))
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts("Code Action"))
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts("references"))
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts("Rename symbols"))
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts())
end)

lsp.setup()
