# Path Definitions
switch (uname)
    case Linux
        source ./os/linux.fish
    case Darwin
        source ./os/darwin.fish
    case Windows
        source ./os/windows.fish
end

