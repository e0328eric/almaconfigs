# set fish shell
set fish_color_normal normal
set fish_color_command 99cc99
set fish_color_quote ffcc66
set fish_color_end cc99cc
set fish_color_redirection d3d0c8
set fish_color_error f2777a
set fish_color_param d3d0c8
set fish_color_selection white --bold --background=brblack
set fish_color_search_match bryellow --background=brblack
set fish_color_history_current --bold
set fish_color_operator 6699cc
set fish_color_escape 66cccc
set fish_color_cwd green
set fish_color_cwd_root red
set fish_color_valid_path --underline
set fish_color_autosuggestion 747369
set fish_color_user brgreen
set fish_color_host normal
set fish_color_cancel -r
set fish_pager_color_completion normal
set fish_pager_color_description B3A06D yellow
set fish_pager_color_prefix white --bold --underline
set fish_pager_color_progress brwhite --background=cyan
set fish_color_comment ffcc66
set fish_color_match 1EB176
set pure_color_info cyan
set pure_color_success 268BD2
set pure_color_primary 6699CC

# Path Definitions
switch (uname)
    case Linux
        set PATH $PATH ~/.local/bin
        set PATH $PATH ~/.cabal/bin
        set PATH $PATH ~/.ghcup/bin
        set PATH $PATH ~/.ghcup/env
        set PATH $PATH ~/.cargo/bin
        set --universal -x GOPATH ~/.go
        set PATH $PATH $GOROOT/bin:$GOPATH/bin
        set GOLSPPATH $GOPATH/src/github.com/ajaymt/golsp

        function emptytrash
            rm -rf /home/almagest/.local/share/Trash
            rm -rf /home/almagest/.local/share/vifm/Trash
        end

    case Darwin
        set PATH $PATH /usr/local/texlive/2021/bin/universal-darwin
        set PATH $PATH /Users/almagest/.local/bin
        set PATH $PATH /Users/almagest/.cargo/bin
        set PATH $PATH /Users/almagest/.go/bin
        set PATH $PATH /Users/almagest/.ghcup/bin
        set PATH $PATH /Users/almagest/.cabal/bin
        set PATH $PATH /Users/almagest/.nimble/bin
        set PATH $PATH /Users/almagest/.flutter/bin
        set PATH $PATH /Users/almagest/.npm-global/bin
        set PATH $PATH /usr/local/bin
        set PATH $PATH /usr/local/opt/qt/bin
        set PATH $PATH /usr/local/opt/llvm/bin
        set PATH $PATH /usr/local/Cellar/gcc/11.1.0_1/bin
        set PATH $PATH /usr/local/opt/python@3.10/Frameworks/Python.framework/Versions/3.10/bin
        set PATH $PATH /opt/local/bin
        set PATH $PATH /opt/local/sbin
        set --universal -x GOPATH ~/.go
        set PATH $PATH $GOROOT/bin:/$GOPATH/bin
        set CC /usr/local/bin/gcc-11
        set CXX /usr/local/bin/g++-11
        fish_add_path /usr/local/opt/llvm/bin
        set -gx LDFLAGS "-L/usr/local/opt/llvm/lib"
        set -gx CPPFLAGS "-I/usr/local/opt/llvm/include"
        set VCPKG_ROOT $HOME/vcpkg
end

function c
    clear
end

function v
    nvim $argv
end

function t
    tmux $argv
end

function l
    ls -al $argv
end

function lg
    lazygit $argv
end

function view
    nvim -R $argv
end

function ls
    exa $argv
end

function vimcfg
    nvim ~/.config/nvim/init.vim
end

function fishcfg
    nvim ~/.config/fish/config.fish
end

function reloadfish
    source ~/.config/fish/config.fish
end

function getmusic
    youtube-dl -x --audio-format m4a $argv
end

function gitall
    git add . && git commit -m $argv && git push origin master
end

function s
    ls $argv
end

function shtobat
    npx bash-converter $argv
end

function hakwon
    switch (uname)
        case Linux
            echo "*.*"

        case Darwin
            cd ~/pCloud/TeX_Documents/Hakwon
    end
end

function cfmtcp
    cp ~/Github/arch-almagest/.clang-format .
end


starship init fish | source

thefuck --alias | source
fish_add_path /usr/local/opt/bison/bin
