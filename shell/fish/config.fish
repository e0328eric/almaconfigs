# Path Definitions
switch (uname)
    case Linux
        source ~/.config/fish/os/linux.fish
    case Darwin
        source ~/.config/fish/os/darwin.fish
    case Windows
        source ./os/windows.fish
end

