" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-speeddating'
Plug 'glts/vim-radical'
Plug 'tpope/vim-repeat'
Plug 'suy/vim-context-commentstring'
Plug 'RRethy/vim-illuminate'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'antoyo/vim-licenses'
Plug 'junegunn/vim-easy-align'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'ziglang/zig.vim'
Plug 'rust-lang/rust.vim'
Plug 'mhinz/vim-crates'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent'
Plug 'cdelledonne/vim-cmake'
Plug 'bfrg/vim-cpp-modern'
Plug 'alaviss/nim.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'airblade/vim-rooter'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-sleuth'
Plug 'sheerun/vim-polyglot'
Plug 'ryanoasis/vim-devicons'
Plug 'alvan/vim-closetag'
Plug 'chriskempson/base16-vim'
Plug 'arzg/vim-colors-xcode'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() }}
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'ggandor/lightspeed.nvim'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'jreybert/vimagit'
Plug 'voldikss/vim-floaterm'
Plug 'mhinz/vim-startify'
Plug 'liuchengxu/vim-which-key'
Plug 'junegunn/goyo.vim'
Plug 'SirVer/ultisnips'
Plug 'metakirby5/codi.vim'
Plug 'mbbill/undotree'
Plug 'ChristianChiarulli/far.vim'
Plug 'AndrewRadev/tagalong.vim'
Plug 'turbio/bracey.vim'
Plug 'psliwka/vim-smoothie'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'mattn/vim-gist'
Plug 'mattn/webapi-vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'luochen1990/rainbow'
Plug 'ntpeters/vim-better-whitespace'
Plug 'moll/vim-bbye'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jelera/vim-javascript-syntax'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

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
