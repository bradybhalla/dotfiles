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


## Main Components
### iTerm2
- Powerlevel10k
- `⌃⌥⌘ T` for hotkey window
- Catppuccin theme
- MesloLGS Nerd Font

### Keyboard Maestro
- `⌥ <space>` for window control
- `⌃⌥⌘ <space>` to quickly open an app
- Various other shortcuts

### Neovim
- Catppuccin theme
- LSP, completion, telescope, and more
- `:Lazy` to install packages, `:TSInstall <language>` to install a new syntax, `:Mason` to install a new LSP server

### Helpful zsh things
- `Ctrl-T` to pick a file using fzf
- `Ctrl-R` to pick a previous command using fzf
- `<command> <directory>/**` + `tab` to pick a file in another directory with fzf
- `sd` to jump to any directory under the home directory
- `nd` to open any directory under the home directory in Neovim


## Tools to install
### Powerlevel10k
- Very nice prompt

### fzf
- Fuzzy finder

### ripgrep
- `grep` but more powerful
- Easily search recursively for text

### lazygit
- Git UI in the terminal

### tmux
- Terminal multiplexer
- Prefix is \` (backtick)
- I usually use iTerm to handle tmux instead of running it directly.  `tmux -CC` starts a session with iTerm.
