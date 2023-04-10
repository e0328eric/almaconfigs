export EDITOR=nvim
export VISUAL=nvim
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source ~/.zsh_local/headline.zsh-theme

source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/texlive/2022/bin/universal-darwin:$PATH"
export PATH="/Users/almagest/.local/bin:$PATH"
export PATH="/Users/almagest/.local/i686-elf/bin:$PATH"
export PATH="/Users/almagest/.local/x86_64-elf/bin:$PATH"
export PATH="/Users/almagest/.cargo/bin:$PATH"
export PATH="/Users/almagest/.go/bin:$PATH"
export PATH="/Users/almagest/.ghcup/bin:$PATH"
export PATH="/Users/almagest/.cabal/bin:$PATH"
export PATH="/Users/almagest/.nimble/bin:$PATH"
export PATH="/Users/almagest/.flutter/bin:$PATH"
export PATH="/Users/almagest/.npm-global/bin:$PATH"
export PATH="/Users/almagest/.opam/default/bin:$PATH"
export PATH="/usr/local/opt/qt/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/Cellar/gcc/11.1.0_1/bin:$PATH"
export PATH="/usr/local/opt/python@3.10/Frameworks/Python.framework/Versions/3.10/bin:$PATH"
export PATH="/Users/almagest/Library/Application\ Support/Coursier/bin:$PATH"
export PATH="/opt/local/bin:$PATH"
export PATH="/opt/local/sbin:$PATH"
export PATH="/Users/almagest/.local/share/nvim/mason/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# export WASMTIME_HOME "$WASMTIME_HOME:$HOME/.wasmtime"

export DYLD_LIBRARY_PATH="/Users/almagest/.rustup/toolchains/stable-x86_64-apple-darwin/lib:$DYLD_LIBRARY_PATH"
export DYLD_LIBRARY_PATH="/Users/almagest/.local/gnu/lib:$DYLD_LIBRARY_PATH"

export LDFLAGS="$LDFLAGS -L/usr/local/lib"
export CFLAGS="$CFLAGS -I/usr/local/include"

export LDFLAGS="$LDFLAGS -L/usr/local/opt/llvm/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/llvm/include"


# Define aliases
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias c="clear"
alias v="nvim"
alias h="hx"
alias lg="lazygit"
alias ls="exa"
alias la="exa"
alias s="exa"
alias view="nvim -R"
alias e="emacs -nw"
alias t="tmux"
alias z="zellij"
alias l="ls -al"
alias hexdump="hexyl"
alias oldrm="/bin/rm"
alias rm="xilo"
alias getmusic="youtube-dl -x --audio-format m4a"

alias zshcfg="nvim ~/.zshrc"
alias reloadzsh="source ~/.zshrc"
alias vimcfg="nvim ~/.config/nvim/init.vim"
alias cmakeinit="$EDITOR CMakeLists.txt"
alias cfmtcp="cp ~/Github/arch-almagest/format/.clang-format ."

# location alias

alias minireport="cd ~/Nextcloud/TeX_Documents/Mini_Report"
alias voca="cd /Users/almagest/Nextcloud/Voca"
alias notetaking="cd ~/Nextcloud/TeX_Documents/NoteTaking"
alias homework="cd ~/Nextcloud/TeX_Documents/Homework"
alias hakwon="cd ~/Nextcloud/TeX_Documents/Hakwon"
