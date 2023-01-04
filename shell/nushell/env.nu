# Nushell Environment Config File

def create_left_prompt [] {
    let path_segment = if (is-admin) {
        $"(ansi red_bold)($env.PWD)"
    } else {
        $"(ansi green_bold)($env.PWD)"
    }

    $path_segment
}

def create_right_prompt [] {
    let time_segment = ([
        (date now | date format '%m/%d/%Y %r')
    ] | str join)

    $time_segment
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = { "" }
let-env PROMPT_INDICATOR_VI_INSERT = { "" }
let-env PROMPT_INDICATOR_VI_NORMAL = { "" }
let-env PROMPT_MULTILINE_INDICATOR = { "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

alias s = ls
alias v = nvim
alias h = hx
alias t = tmux
alias lg = lazygit
alias hakwon = cd "~/pCloud/TeX_Documents/Hakwon"
alias minireport = cd "~/pCloud/TeX_Documents/Mini_Report"
alias notetaking = cd "~/pCloud/TeX_Documents/NoteTaking"
alias homework = cd "~/pCloud/TeX_Documents/Homework"
alias voca = cd "~/pCloud/Voca"
alias cmakeinit = nvim "CMakeLists.txt"

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
let-env PATH = (
    $env.PATH                                                                         |
    append "/usr/local/bin"                                                           |
    append "/usr/local/opt/qt/bin"                                                    |
    append "/usr/local/opt/llvm/bin"                                                  |
    append "/usr/local/Cellar/gcc/11.1.0_1/bin"                                       |
    append "/usr/local/opt/python@3.10/Frameworks/Python.framework/Versions/3.10/bin" |
    append "/Users/almagest/Library/Application Support/Coursier/bin"                 |
    append "/opt/local/bin"                                                           |
    append "/opt/local/sbin"                                                          |
    append "/Users/almagest/.local/bin"                                               |
    append "/Users/almagest/.cabal/bin"                                               |
    append "/Users/almagest/.cargo/bin"                                               |
    append "/Users/almagest/.go/bin"                                                  |
    append "/Users/almagest/.ghcup/bin"                                               |
    append "/Users/almagest/.cabal/bin"                                               |
    append "/Users/almagest/.nimble/bin"                                              |
    append "/Users/almagest/.flutter/bin"                                             |
    append "/Users/almagest/.npm-global/bin"                                          |
    append "/Users/almagest/.opam/default/bin"
  )
