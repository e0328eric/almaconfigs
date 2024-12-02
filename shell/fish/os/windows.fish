set PATH $PATH ~/.local/bin
set PATH $PATH ~/.local/gcc/bin
set PATH $PATH ~/.local/farbfeld
set PATH $PATH /c/ghcup/bin
set PATH $PATH /c/Users/almag/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin
set PATH $PATH /c/Users/almag/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib
set PATH $PATH /c/Users/almag/.cargo/bin
set PATH $PATH /c/Users/almag/.local/zig
set PATH $PATH ~/.nimble/bin
set PATH $PATH ~/.local/share/nvim/mason/bin
set PATH $PATH /c/Program\ Files/Neovim/bin
set -gx INCLUDE '/home/almag/.local/fasm/INCLUDE'

function winhome
    cd /c/Users/almag/
end

function v
    nvim $argv
end

function oldrm
    /usr/bin/rm $argv
end

function rm
    xilo $argv
end

function c
    clear
end

function pbcopy
    win32yank.exe -i $argv
end

function lg
    lazygit $argv
end

function fishcfg
    nvim ~/.config/fish/config.fish
end

function reloadfish
    source ~/.config/fish/config.fish
end

function s
    ls $argv
end

function hakwon
    cd /p/AlmaFiles/TeX_Documents/Hakwon
end

function minireport
    cd /p/AlmaFiles/TeX_Documents/Mini_Report
end

function notetaking
    cd /p/AlmaFiles/TeX_Documents/NoteTaking
end

function homework
    cd /p/AlmaFiles/TeX_Documents/Homework
end

function lecturenote
    cd /p/AlmaFiles/TeX_Documents/Lecture_Note
end

function mathbook
    cd /p/AlmaFiles/Math
end

function teachingf
    cd /p/AlmaFiles/TeX_Documents/TF
end

function seminar
    cd /p/AlmaFiles/TeX_Documents/Seminar
end

function kindergarden
    cd /p/AlmaFiles/TeX_Documents/Kindergarden
end

starship init fish | source


