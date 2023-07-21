# dotfiles

A few of my more important dotfiles. Meant for use with zsh. If not using homebrew to install command line tools, some paths in .zshrc may need to be changed.

## Setup
```bash
chmod +x configure.sh
./configure.sh
```
This script will back up existing files and copy everything in this repository to the correct location in the home directory.

## Components
### Powerlevel10k
<!-- TODO: add notes -->

### tmux
- Prefix is \` (backtick)

### Neovim
- `:Lazy` to install packages
- `:TSInstall <language>` to install a new syntax, `:Mason` to install a new LSP server
- Catppuccin theme

## Other tools to install
### fzf
<!-- TODO: add notes -->

### ripgrep
<!-- TODO: add notes -->