"""""""""""""""""""""""""""""""""""""""""""""""""""
"  Package Manager
"""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Theme Related Packages
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'chriskempson/base16-vim'

    " Languages
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'ziglang/zig.vim'
	Plug 'rust-lang/rust.vim'
	Plug 'mhinz/vim-crates'
	Plug 'luochen1990/rainbow'
	Plug 'bfrg/vim-cpp-modern'
	Plug 'udalov/kotlin-vim'
    Plug 'google/vim-maktaba' | Plug 'google/vim-codefmt' | Plug 'google/vim-glaive'
    " Plug 'nvim-lua/plenary.nvim' | Plug 'scalameta/nvim-metals'
    Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() }}

	" ultisnips
	Plug 'SirVer/ultisnips'

    " which-keys
	Plug 'folke/which-key.nvim'

	" telescope
	Plug 'nvim-lua/plenary.nvim' | Plug 'nvim-telescope/telescope.nvim'

	" Miscellaneous
    Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
	Plug 'antoyo/vim-licenses'
	Plug 'ggandor/lightspeed.nvim'
	Plug 'terrortylor/nvim-comment'
	Plug 'voldikss/vim-floaterm'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua', { 'tag': 'master' }
    " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

"""""""""""""""""""""""""""""""""""""""""""""""""""
"  Basic Options
"""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
"set iskeyword+=-
set autoindent
set background=dark
set clipboard=unnamedplus
set cmdheight=2
set conceallevel=0
set cursorline
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set formatoptions-=cro
set formatoptions-=cro
set guifont=Fira\ Code\ Nerd\ Font
set hidden
set incsearch
set laststatus=3
set mouse=n
set nobackup
set noshowmode
set nowrap
set nowritebackup
set nu rnu
set pumheight=10
set ruler
set scrolloff=3
set shiftwidth=4
set shortmess+=c
set showtabline=2
set signcolumn=yes
set smartindent
set smarttab
set splitbelow
set splitright
set t_Co=256
set tabstop=4
set termguicolors
set timeoutlen=100
set updatetime=300

" transparent neovim
" au ColorScheme * hi Normal ctermbg=none guibg=none"

" import filetypes
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au BufRead,BufNewFile *.ves set filetype=vesti
au BufRead,BufNewFile *.asm set filetype=nasm
filetype plugin indent on

" Detect .h file as pure C header one
augroup project
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END

if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""
"  Theme Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""
let base16colorspace=256
set termguicolors
colorscheme base16-eighties

"""""""""""""""""""""""""""""""""""""""""""""""""""
"  Keybindings (Basic)
"""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=' '
lua << EOF
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
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""
"  Keybindings (which-key)
"""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
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
		["/"] = { ':call Comment()', "comment" },
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
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""
"  ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<TAB>"
let g:UltiSnipsJumpForwardTrigger="<TAB>"
let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
let g:UltiSnipsUsePythonVersion = 3

let g:UltiSnipsSnippetDirectories=['~/.config/nvim/snips']

let g:python_highlight_all = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""
"  vim-codefmt
"""""""""""""""""""""""""""""""""""""""""""""""""""
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""
"  nvim-tree
"""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
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
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""
"  coc-nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = [
    \ 'coc-actions',
    \ 'coc-css',
    \ 'coc-cssmodules',
    \ 'coc-emmet',
    \ 'coc-emoji',
    \ 'coc-explorer',
    \ 'coc-floaterm',
    \ 'coc-highlight',
    \ 'coc-html',
    \ 'coc-java',
    \ 'coc-java-debug',
    \ 'coc-json',
    \ 'coc-lists',
    \ 'coc-marketplace',
    \ 'coc-metals',
    \ 'coc-prettier',
    \ 'coc-rust-analyzer',
    \ 'coc-sh',
    \ 'coc-svg',
    \ 'coc-tabnine',
    \ 'coc-tasks',
    \ 'coc-tsserver',
    \ 'coc-vimlsp',
    \ 'coc-xml',
    \ 'coc-yaml',
    \ 'coc-yank',
    \ ]

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <C-]>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><C-S-]> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Explorer
let g:coc_explorer_global_presets = {
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 30,
\   },
\   'floatingRightside': {
\      'position': 'floating',
\      'floating-position': 'right-center',
\      'floating-width': 30,
\   },
\   'simplify': {
\     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }
"nmap <silent> <space>e :CocCommand explorer<CR>
" nnoremap <silent> <leader>e :CocCommand explorer<CR>
" nmap <space>f :CocCommand explorer --preset floatingRightside<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" Snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

