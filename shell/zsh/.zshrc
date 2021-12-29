export EDITOR=nvim
export VISUAL=nvim
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/almagest/.oh-my-zsh"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export PATH="$PATH:/usr/local/texlive/2021/bin/universal-darwin"
export PATH="/Users/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="/Users/almagest/.local/bin:$PATH"
export PATH="/Users/almagest/.cargo/bin:$PATH"
export PATH="/Users/almagest/.go/bin:$PATH"
export PATH="/Users/almagest/.ghcup/bin:$PATH"
export PATH="/Users/almagest/.cabal/bin:$PATH"
export PATH="/Users/almagest/.nimble/bin:$PATH"
export PATH="/Users/almagest/.flutter/bin:$PATH"
export PATH="/Users/almagest/.npm-global/bin:$PATH"
export PATH="/usr/local/opt/qt/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/Cellar/gcc/11.1.0_1/bin:$PATH"
export PATH="/usr/local/opt/python@3.10/Frameworks/Python.framework/Versions/3.10/bin:$PATH"
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin
export VISUAL=nvim
export EDITOR="$VISUAL"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/

export LDFLAGS="-L/usr/local/opt/qt/lib:$LDFLAGS"
export LDFLAGS="-L/usr/local/opt/llvm/lib:$LDFLAGS"
export CPPFLAGS="-I/usr/local/opt/qt/include:$CPPFLAGS"
export CPPFLAGS="-I/usr/local/opt/llvm/include:$CPPFLAGS"
export PKG_CONFIG_PATH="/usr/local/opt/qt/lib/pkgconfig"

# Define aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias c='clear'
alias v='nvim'
alias view='nvim -R'
alias e='emacs -nw'
alias t='tmux'
alias hexdump='hexyl'
alias doom='~/.emacs.d/bin/doom'
alias ls='exa'
alias s='ls'
alias gcc='gcc-11'
alias wez='wezterm'
# alias vols='amixer -D pulse sset Master'
alias getmusic='youtube-dl -x --audio-format m4a'
alias hakwon='cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/TeX_Documents/Hakwon'
alias autohaskell="stack exec ghcid"
alias gitall="git add --all && git commit -m"

# This command can be run while .clang-format is in the .config directory
alias cfmtcp='cp ~/.config/.clang-format .'

# copy cb file
alias mkcb='cp ~/Github/arch-almagest/script/cpp-bootstrap/cb .'

# alias emptytrash="rm -rf ~/.local/share/Trash && rm -rf ~/.local/share/vifm/Trash"

# Load Configures
# alias qutecfg="vim ~/.config/qutebrowser/config.py"
# alias xmonadcfg="vim ~/.xmonad/xmonad.hs"
# alias polybarcfg="vim ~/.config/polybar/config"
alias zshcfg="vim ~/.zshrc"
alias vimcfg='vim ~/.vimrc'
# alias urxvtreset="xrdb ~/.Xresources"

eval $(thefuck --alias)
eval "$(starship init zsh)"

