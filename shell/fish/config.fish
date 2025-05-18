# Path Definitions
switch (uname)
    case Linux
        source ~/.config/fish/os/linux.fish
    case Darwin
        source ~/.config/fish/os/darwin.fish
    case Windows
        source ./os/windows.fish
end


set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/almagest/.ghcup/bin $PATH # ghcup-env