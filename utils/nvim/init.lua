local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

g.mapleader = " "

vim.cmd [[packadd packer.nvim]]
require('packer').startup(
  function(use)
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-commentary'
    use 'mhartington/formatter.nvim'
    use 'neovim/nvim-lspconfig'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'nvim-telescope/telescope-dap.nvim'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'
    use 'David-Kunz/jester'
    use 'nvim-treesitter/playground'
    use 'kyazdani42/nvim-tree.lua'
    use 'David-Kunz/treesitter-unit'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'onsails/lspkind-nvim'
    use 'David-Kunz/cmp-npm'
    use 'ggandor/lightspeed.nvim'
    use 'mfussenegger/nvim-dap'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'voldikss/vim-floaterm'
    use 'mg979/vim-visual-multi'
    use 'SirVer/ultisnips'
    use 'luochen1990/rainbow'
    use 'chriskempson/base16-vim'
  end
)

  
-- default options
opt.completeopt = {'menu', 'menuone', 'noselect'}
opt.mouse = 'a'
opt.splitright = true
opt.splitbelow = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.relativenumber = true
opt.termguicolors = true
-- set diffopt+=vertical " starts diff mode in vertical split
opt.cmdheight = 1
-- set shortmess+=c " don't need to press enter so often
opt.signcolumn = 'yes'
opt.updatetime = 520
opt.undofile = true
opt.clipboard = 'unnamedplus'
cmd('filetype plugin on')
opt.backup = false
g.netrw_banner = false
g.netrw_liststyle = 3
g.markdown_fenced_languages = { 'javascript', 'js=javascript', 'json=javascript' }
cmd([[
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au BufRead,BufNewFile *.ves set filetype=vesti
au BufRead,BufNewFile *.glasm set filetype=glasm
au BufRead,BufNewFile *.asm set filetype=nasm
filetype plugin indent on
]])

-- opt.path:append({ "**" })
vim.cmd([[set path=$PWD/**]])

vim.cmd('let base16colorspace=256')
vim.cmd('colorscheme base16-gruvbox-dark-hard')

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- local function map(mode, l, r, opts)
--       opts = opts or {}
--       opts.buffer = bufnr
--       vim.api.keymap.set(mode, l, r, opts)
-- end

map('n', '<leader>v', ':e $MYVIMRC<CR>')
map('n', '<C-\\>', 'O')


-- lewis6991/gitsigns.nvim

_G.diffThisBranch = function()
 local branch = vim.fn.input("Branch: ", "")
 require"gitsigns".diffthis(branch)
end

require('gitsigns').setup({
  current_line_blame = true,
  on_attach = function(bufnr)
       -- Navigation
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

    -- Actions
    map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
    map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
    map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
    map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
    map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    map('n', '<leader>hm', '<cmd>lua require"gitsigns".diffthis("main")<CR>')
    map('n', '<leader>hM', '<cmd>lua diffThisBranch()<CR>')
    map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

    -- Text object
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})

-- sbdchd/neoformat
map('n', '<leader>F', ':Format<CR>')
require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    },
    rust = {
      function()
        return {
          exe = "rustfmt",
          stdin = true
        }
      end
    },
    sql = {
        -- prettierd
       function()
          return {
            exe = "sqlformat",
            args = {vim.api.nvim_buf_get_name(0), '-a'},
            stdin = true
          }
        end
    },
  }
})
local telescope_actions = require("telescope.actions.set")

local fixfolds = {
	hidden = true,
	attach_mappings = function(_)
		telescope_actions.select:enhance({
			post = function()
				vim.cmd(":normal! zx")
			end,
		})
		return true
	end,
}
-- local fb_actions = require "telescope".extensions.file_browser.actions
-- mappings in file_browser extension of telescope.setup

local actions = require("telescope.actions")


require('telescope').setup {
	pickers = {
		buffers = fixfolds,
		find_files = fixfolds,
		git_files = fixfolds,
		grep_string = fixfolds,
		live_grep = fixfolds,
		oldfiles = fixfolds,
	},
}

-- nvim-telescope/telescope.nvim
_G.telescope_find_files_in_path = function(path)
 local _path = path or vim.fn.input("Dir: ", "", "dir")
 require("telescope.builtin").find_files({search_dirs = {_path}})
end
_G.telescope_live_grep_in_path = function(path)
 local _path = path or vim.fn.input("Dir: ", "", "dir")
 require("telescope.builtin").live_grep({search_dirs = {_path}})
end
_G.telescope_files_or_git_files = function()
 local utils = require('telescope.utils')
 local builtin = require('telescope.builtin')
 local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
 if ret == 0 then
   builtin.git_files()
 else
   builtin.find_files()
 end
end
map('n', '<leader>fD', ':lua telescope_live_grep_in_path()<CR>')
map('n', '<leader><space>', ':lua telescope_files_or_git_files()<CR>')
map('n', '<leader>fd', ':lua telescope_find_files_in_path()<CR>')
map('n', '<leader>ft', ':lua telescope_find_files_in_path("./tests")<CR>')
map('n', '<leader>fT', ':lua telescope_live_grep_in_path("./tests")<CR>')
map('n', '<leader>ff', ':Telescope live_grep<CR>')
-- map('n', '<leader>fo', ':Telescope file_browser<CR>')
map('n', '<leader>fn', ':Telescope find_files<CR>')
map('n', '<leader>fr', ':Telescope resume<CR>')
map('n', '<leader>fg', ':Telescope git_branches<CR>')
map('n', '<leader>fj', ':Telescope buffers<CR>')
map('n', '<leader>fs', ':Telescope lsp_document_symbols<CR>')
map('n', '<leader>ff', ':Telescope live_grep<CR>')
map('n', '<leader>FF', ':Telescope grep_string<CR>')


-- David-Kunz/cmp-npm
require('cmp-npm').setup({ ignore = {"beta", "rc"} })


local nvim_lsp = require'lspconfig'
local servers = { 'tsserver', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
end


map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
map('n', 'gh', ':lua vim.lsp.buf.hover()<CR>')
map('n', 'ga', ':Telescope lsp_code_actions<CR>')
map('n', 'gA', ':Telescope lsp_range_code_actions<CR>')
map('n', 'gD', ':lua vim.lsp.buf.implementation()<CR>')
map('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
map('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
map('n', 'gR', ':lua vim.lsp.buf.rename()<CR>')
 

map('n', '<leader><esc><esc>', ':tabclose<CR>')


vim.g.floaterm_width = 0.95
vim.g.floaterm_height = 0.95
map('n', '<leader>gi', ':FloatermNew lazygit<CR>')
map('n', '<leader>gg', ':Telescope git_status<CR>')


cmd('set foldmethod=expr')
cmd('set foldexpr=nvim_treesitter#foldexpr()')

map('n', '<leader>n', ':tabe ~/tmp/notes.md<CR>')


local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.cds = {
      install_info = {
            -- local path or git repo
            url = "~/apps/tree-sitter-cds",
            files = { "src/parser.c", "src/scanner.c" }
      },
      filetype = "cds",
      -- additional filetypes that use this parser
      used_by = { "cdl", "hdbcds" }
    }

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  -- indent = {
  --   enable = true
  -- },
}
-- mfussenegger/nvim-dap
local dap = require('dap')
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/apps/node/out/src/nodeDebug.js'},
}

-- require('dap').set_log_level('INFO')
dap.defaults.fallback.terminal_win_cmd = '20split new'
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})


map('n', '<leader>dh', ':lua require"dap".toggle_breakpoint()<CR>')
map('n', '<leader>dH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map('n', '<A-k>', ':lua require"dap".step_out()<CR>')
map('n', "<A-l>", ':lua require"dap".step_into()<CR>')
map('n', '<A-j>', ':lua require"dap".step_over()<CR>')
map('n', '<A-h>', ':lua require"dap".continue()<CR>')
map('n', '<leader>dn', ':lua require"dap".run_to_cursor()<CR>')
map('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
map('n', '<leader>dj', ':lua require"dap".down()<CR>zz')
map('n', '<leader>dc', ':lua require"dap".terminate()<CR>')
map('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
map('n', '<leader>dR', ':lua require"dap".clear_breakpoints()<CR>')
map('n', '<leader>de', ':lua require"dap".set_exception_breakpoints({"all"})<CR>')
map('n', '<leader>da', ':lua require"debugHelper".attach()<CR>')
map('n', '<leader>dA', ':lua require"debugHelper".attachToRemote()<CR>')
map('n', '<leader>di', ':lua require"dap.ui.widgets".hover()<CR>')
map('n', '<leader>d?', ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')

-- nvim-telescope/telescope-dap.nvim
require('telescope').load_extension('dap')
map('n', '<leader>ds', ':Telescope dap frames<CR>')
-- map('n', '<leader>dc', ':Telescope dap commands<CR>')
map('n', '<leader>db', ':Telescope dap list_breakpoints<CR>')

-- nvim-telescope/telescope-file-browser.nvim
-- require('telescope').load_extension('file_browser')
-- theHamsta/nvim-dap-virtual-text and mfussenegger/nvim-dap
require('nvim-dap-virtual-text').setup()
-- g.dap_virtual_text = true

-- David-Kunz/jester
map('n', '<leader>tt', ':lua require"jester".run({ path_to_jest = "/usr/local/bin/jest" })<cr>')
map('n', '<leader>t_', ':lua require"jester".run_last({ path_to_jest = "/usr/local/bin/jest" })<cr>')
map('n', '<leader>tf', ':lua require"jester".run_file({ path_to_jest = "/usr/local/bin/jest" })<cr>')
-- map('n', '<leader>dd', ':lua require"jester".debug({ path_to_jest = "/usr/local/bin/jest" })<cr>')
map('n', '<leader>d_', ':lua require"jester".debug_last({ path_to_jest = "/usr/local/bin/jest" })<cr>')
map('n', '<leader>df', ':lua require"jester".debug_file({ path_to_jest = "/usr/local/bin/jest" })<cr>')
map('n', '<leader>dq', ':lua require"jester".terminate()<cr>')

-- map('n', '<leader>dd', ':lua require"jester".debug({ path_to_jest = "/usr/local/bin/jest", dap = { type = "node2" } })<cr>')
map('n', '<leader>dd', ':lua require"jester".debug({ path_to_jest = "/usr/local/bin/jest" })<cr>')
-- lua language server
 local system_name
 if vim.fn.has("mac") == 1 then
   system_name = "macOS"
 elseif vim.fn.has("unix") == 1 then
   system_name = "Linux"
 elseif vim.fn.has('win32') == 1 then
   system_name = "Windows"
 else
   print("Unsupported system for sumneko")
 end
 
-- junegunn/goyo.vim
g.goyo_width = 120
-- map('n', '<leader>z', ':Goyo<CR>')


map('n', '[b', ':bnext<CR>')
map('n', ']b', ':bprev<CR>')

-- David-Kunz/treesitter-unit
map('x', 'u', ':<c-u>lua require"treesitter-unit".select(true)<CR>')
map('o', 'u', ':<c-u>lua require"treesitter-unit".select(true)<CR>')
-- require"treesitter-unit".enable_highlighting()

-- custom folder icon
require'nvim-web-devicons'.setup({
  override = {
    lir_folder_icon = {
      icon = "",
      color = "#7ebae4",
      name = "LirFolderNode"
    },
  }
})
-- use visual mode
function _G.LirSettings()
  vim.api.nvim_buf_set_keymap(0, 'x', 'J', ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>', {noremap = true, silent = true})

  -- echo cwd
  vim.api.nvim_echo({{vim.fn.expand('%:p'), 'Normal'}}, false, {})
end
vim.cmd [[augroup lir-settings]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
vim.cmd [[augroup END]]

-- global mark I for last edit
vim.cmd [[autocmd InsertLeave * execute 'normal! mI']]

-- highlight on yank
vim.cmd([[au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}]])

-- kyazdani42/nvim-tree.lua
require('nvim-tree').setup({
  hijack_cursor = true,
  update_focused_file = { enable = true },
  view = {
    width = 60
  }
})
map('n', '\\', ':NvimTreeToggle<CR>', {silent=true})

map('n', 'gq', ':bd!<CR>')
map('n', '<leader>w', ':w<CR>')

vim.cmd('iabbrev :tup: 👍')
vim.cmd('iabbrev :tdo: 👎')
vim.cmd('iabbrev :smi: 😊')
vim.cmd('iabbrev :sad: 😔')
vim.cmd('iabbrev darkred #8b0000')
vim.cmd('iabbrev darkgreen #006400')


_G.term_buf_of_tab = _G.term_buf_of_tab or {}
_G.term_buf_max_nmb = _G.term_buf_max_nmb or 0

function spawn_terminal()
  local cur_tab = vim.api.nvim_get_current_tabpage()
  vim.cmd('vs | terminal')
  local cur_buf = vim.api.nvim_get_current_buf()
  _G.term_buf_max_nmb = _G.term_buf_max_nmb + 1
  vim.api.nvim_buf_set_name(cur_buf, "Terminal " .. _G.term_buf_max_nmb)
  table.insert(_G.term_buf_of_tab, cur_tab, cur_buf)
  vim.cmd(':startinsert')
end

_G.toggle_terminal = function()
  local cur_tab = vim.api.nvim_get_current_tabpage()
  local term_buf = term_buf_of_tab[cur_tab]
  if term_buf ~= nil then
   local cur_buf = vim.api.nvim_get_current_buf()
   if cur_buf == term_buf then
     vim.cmd('q')
   else
     vim.cmd('vert sb' .. term_buf)
     vim.cmd(':startinsert')
   end
  else
    spawn_terminal()
    -- vim.cmd('vs | terminal')
    -- local cur_buf = vim.api.nvim_get_current_buf()
    -- _G.term_buf_max_nmb = _G.term_buf_max_nmb + 1
    -- vim.api.nvim_buf_set_name(cur_buf, "Terminal " .. _G.term_buf_max_nmb)
    -- table.insert(term_buf_of_tab, cur_tab, cur_buf)
    vim.cmd(':startinsert')
  end
end
map('n', '<c-y>', ':lua toggle_terminal()<CR>')
map('i', '<c-y>', '<ESC>:lua toggle_terminal()<CR>')
map('t', '<c-y>', '<c-\\><c-n>:lua toggle_terminal()<CR>')
cmd([[
if has('nvim')
   au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
endif]])

_G.send_line_to_terminal = function()
  local curr_line = vim.api.nvim_get_current_line()
  local cur_tab = vim.api.nvim_get_current_tabpage()
  local term_buf = term_buf_of_tab[cur_tab]
  if term_buf == nil then
    spawn_terminal()
    term_buf = term_buf_of_tab[cur_tab]
  end
  for _, chan in pairs(vim.api.nvim_list_chans()) do
    if chan.buffer == term_buf then
      chan_id = chan.id
    end
  end
  vim.api.nvim_chan_send(chan_id, curr_line .. '\n')
end

map('n', '<leader>x', ':lua send_line_to_terminal()<CR>')

require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
  }
}

map('n', '<c-o>', '<c-o>zz')
map('n', '<c-i>', '<c-i>zz')

-- 'SirVer/ultisnips'
g.UltiSnipsExpandTrigger = '<C-]>'
g.UltiSnipsJumpForwardTrigger = '<C-]>'
g.UltiSnipsJumpBackwardTrigger = '<C-S-]>'
g.UltiSnipsUsePythonVersion = 3
g.UltiSnipsSnippetDirectories = { '~/.config/nvim/snips' }

-- 'L3MON4D3/LuaSnip'
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local ls = require("luasnip")
local cmp = require("cmp")
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if ls.jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'npm' },
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 5 },
  },
  formatting = {
    format = lspkind.cmp_format({with_text = false, maxwidth = 50})
  }
})

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.expand = function ()
  -- print("hurray!!")
  if ls.expand_or_jumpable() then
    return t("<Plug>luasnip-expand-or-jump")
  end
  return ''
end

_G.expand_back = function ()
  -- print("hurray!!")
  if ls.jumpable(-1) then
    return t("<Plug>luasnip-jump-prev")
  end
  return ''
end

vim.api.nvim_set_keymap('i', '<c-j>', 'v:lua.expand()', { expr = true })
vim.api.nvim_set_keymap('i', '<c-k>', 'v:lua.expand_back()', { expr = true })
vim.api.nvim_set_keymap('s', '<c-j>', 'v:lua.expand()', { expr = true })
vim.api.nvim_set_keymap('s', '<c-k>', 'v:lua.expand_back()', { expr = true })

map('n', '<leader>ls', '<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>')

