# dotfiles

A few of my more important dotfiles. Meant for use with zsh. If not using homebrew to install command line tools, some paths in .zshrc may need to be changed.

## Setup
### 1. dotfiles
```bash
chmod +x configure.sh
./configure.sh
```
This script will back up existing files and copy everything in this repository to the correct location in the home directory.

### 2. iTerm2
In iTerm2 preferences, check "Load preferences from a custom folder or URL" and choose the directory with `com.googlecode.iterm2.plist`.

### 3. Keyboard Maestro
In Keyboard Maestro preferences, check "Sync Macros" and choose `Keyboard Maestro Macros.kmsync`.


## Components
### iTerm2

### Keyboard Maestro

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

### lazygit
