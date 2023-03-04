# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

# Further Installation
First, comment the line that contains `{ import = "plugins" }` in `./lua/config/lazy.lua`.
If not, then lazyvim installation cause an error that `which-key` plugin is not found.

Also, go to `~/.local/share/nvim/lazy/markdown-preview.nvim/`, run the following commands:
```console
yarn install
yarn build
```
