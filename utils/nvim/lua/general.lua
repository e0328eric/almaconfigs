-- General config
vim.opt["autoindent"] = true
vim.opt["autoread"] = true
vim.opt["clipboard"] = "unnamedplus"
vim.opt["colorcolumn"] = "100"
vim.opt["encoding"] = "utf-8"
vim.opt["expandtab"] = true
vim.opt["fileencoding"] = "utf-8"
vim.opt["hidden"] = true
vim.opt["hlsearch"] = true
vim.opt["laststatus"] = 3
vim.opt["mouse"] = "n"
vim.opt["nu"] = true
vim.opt["rnu"] = true
vim.opt["ruler"] = true
vim.opt["scrolloff"] = 3
vim.opt["shiftwidth"] = 4
vim.opt["showmode"] = false
vim.opt["smartindent"] = true
vim.opt["smarttab"] = true
vim.opt["splitbelow"] = true
vim.opt["splitright"] = true
vim.opt["swapfile"] = false
vim.opt["tabstop"] = 4
vim.opt["termguicolors"] = true
vim.opt["title"] = true

-- Persistent undo
-- mkdir $HOME/.vim/undo
vim.opt["undofile"] = true
vim.opt["undodir"] = os.getenv("HOME") .. "/.cache/nvim/undo"
vim.opt["undolevels"] = 1000
vim.opt["undoreload"] = 10000

vim.cmd([[
hi Normal guibg=NONE ctermbg=NONE
let g:neoformat_enabled_cpp = []
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]])

vim.cmd("command CDD cd %:p:h")
