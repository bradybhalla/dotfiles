# dotfiles

A few of my more important dotfiles. Meant for use with zsh on MacOS. If not using homebrew to install command line tools, some paths in .zshrc will need to be changed.

## Main Components

### [Alacritty](https://alacritty.org/)

- Powerlevel10k prompt
- Catppuccin theme
- MesloLGS Nerd Font (install if needed)
- Keybindings for use with tmux

### [Keyboard Maestro](https://www.keyboardmaestro.com)

- `⌥ <space>` for window control
- `⌃⌥⌘ <space>` to quickly open an app
- Various other shortcuts

### [Neovim](https://neovim.io)

- Catppuccin theme
- LSP, completion, telescope, and more

### Helpful zsh things

- `sd` to jump to any directory under the home directory

## Other Tools to Install

### [Homebrew](https://brew.sh)

- Used to install almost everything else

### [Powerlevel10k](https://github.com/romkatv/powerlevel10k)

- Very nice prompt
- Install with homebrew

### [fzf](https://github.com/junegunn/fzf)

- Fuzzy finder
- Keybindings `Ctrl-T` to find a file and `Ctrl-R` to find a previous command
- `<command> <directory>/**` + `tab` to pick a file in another directory
- Install with homebrew

### [ripgrep](https://github.com/BurntSushi/ripgrep)

- better `grep`
- Easily search for text in files recursively through a directory
- Install with homebrew

### [fd](https://github.com/sharkdp/fd)

- better `find`
- Easily search for files
- Install with homebrew

### [lazygit](https://github.com/jesseduffield/lazygit)

- Git UI in the terminal
- Install with homebrew

### [tmux](https://github.com/tmux/tmux)

- Terminal multiplexer
- Prefix is `Ctrl-S`
- Install with homebrew

### [htop](https://htop.dev)

- Interactive process viewer
- Install with homebrew

### [miniconda](https://docs.conda.io/projects/miniconda/en/latest/)

- Python package and version manager
- Install with homebrew

### [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

- Syntax highlighting while typing in zsh
- Install by cloning [https://github.com/zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) into `~/bin`

### [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

- Autocomplete from command history while typing in zsh (right arrow to accept)
- Install by cloning [https://github.com/zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) into `~/bin`

## Setup

### dotfiles

```bash
chmod +x configure.sh
./configure.sh
```

This script will back up existing files and copy everything in this repository to the correct location in the home directory.

### Install everything listed in the ["Other Tools to Install"](#other-tools-to-install) section
1. Once homebrew is installed, run
```bash
brew install neovim powerlevel10k fzf ripgrep fd lazygit tmux htop miniconda
```
2. zsh-syntax-highlighting and zsh-autosuggestions still need to be cloned

### Configure Neovim
1. Open Neovim and wait for plugins to install.
2. Install LSPs, formatters, and syntaxes by typing `:Setup`.
3. Restart Neovim and type `:checkhealth` to make sure everything is working correctly.

### Keyboard Maestro

In Keyboard Maestro preferences, check "Sync Macros" and choose `Keyboard Maestro Macros.kmsync`.
