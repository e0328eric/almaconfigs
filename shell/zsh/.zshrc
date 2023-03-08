export EDITOR=nvim
export VISUAL=nvim
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="candy"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:/usr/local/texlive/2022/bin/universal-darwin"
export PATH="$PATH:/Users/almagest/.local/bin"
export PATH="$PATH:/Users/almagest/.cargo/bin"
export PATH="$PATH:/Users/almagest/.go/bin"
export PATH="$PATH:/Users/almagest/.ghcup/bin"
export PATH="$PATH:/Users/almagest/.cabal/bin"
export PATH="$PATH:/Users/almagest/.nimble/bin"
export PATH="$PATH:/Users/almagest/.flutter/bin"
export PATH="$PATH:/Users/almagest/.npm-global/bin"
export PATH="$PATH:/Users/almagest/.opam/default/bin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/opt/qt/bin"
export PATH="$PATH:/usr/local/opt/llvm/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/usr/local/Cellar/gcc/11.1.0_1/bin"
export PATH="$PATH:/usr/local/opt/python@3.10/Frameworks/Python.framework/Versions/3.10/bin"
export PATH="$PATH:/Users/almagest/Library/Application\ Support/Coursier/bin"
export PATH="$PATH:/opt/local/bin"
export PATH="$PATH:/opt/local/sbin"
export PATH="$PATH:/Users/almagest/.local/share/nvim/mason/bin"
export PATH="$PATH:$GOROOT/bin"
export PATH="$PATH:$GOPATH/bin"

# export WASMTIME_HOME "$WASMTIME_HOME:$HOME/.wasmtime"

export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/Users/almagest/.rustup/toolchains/stable-x86_64-apple-darwin/lib"

# export LDFLAGS="-L/usr/local/opt/qt/lib:$LDFLAGS"
export LDFLAGS="$LDFLAGS:-L/usr/local/opt/llvm/lib"
# export CPPFLAGS="-I/usr/local/opt/qt/include:$CPPFLAGS"
export CPPFLAGS="$CPPFLAGS:-I/usr/local/opt/llvm/include"

# Define aliases
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias c="clear"
alias v="nvim"
alias lg="lazygit"
alias ls="exa"
alias s="exa"
alias view="nvim -R"
alias e="emacs -nw"
alias t="tmux"
alias l="ls -al"
alias hexdump="hexyl"
alias oldrm="/bin/rm"
alias rm="xilo"
alias getmusic="youtube-dl -x --audio-format m4a"

alias zshconfig="nvim ~/.zshrc"
alias reloadzsh="source ~/.zshrc"
alias vimcfg="nvim ~/.config/nvim/init.vim"
alias cmakeinit="$EDITOR CMakeLists.txt"

# location alias

alias minireport="cd ~/Nextcloud/TeX_Documents/Mini_Report"
alias voca="cd /Users/almagest/Nextcloud/Voca"
alias notetaking="cd ~/Nextcloud/TeX_Documents/NoteTaking"
alias homework="cd ~/Nextcloud/TeX_Documents/Homework"
alias hakwon="cd ~/Nextcloud/TeX_Documents/Hakwon"
