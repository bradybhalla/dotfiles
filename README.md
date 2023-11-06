# dotfiles

A few of my more important dotfiles. Meant for use with zsh on MacOS. If not using homebrew to install command line tools, some paths in .zshrc will need to be changed.

## Main Components

### [iTerm2](https://iterm2.com)

- Powerlevel10k
- Catppuccin theme
- MesloLGS Nerd Font (install if needed)

### [Keyboard Maestro](https://www.keyboardmaestro.com)

- `⌥ <space>` for window control
- `⌃⌥⌘ <space>` to quickly open an app
- Various other shortcuts

### [Neovim](https://neovim.io)

- Catppuccin theme
- LSP, completion, telescope, and more
- `:Lazy` to manage plugins, `:Mason` to manage LSPs
- `:checkhealth` to make sure everything is working correctly

### Helpful zsh things

- `Ctrl-T` to pick a file using fzf
- `Ctrl-R` to pick a previous command using fzf
- `<command> <directory>/**` + `tab` to pick a file in another directory with fzf
- `sd` to jump to any directory under the home directory

## Other Tools to Install

### [Homebrew](https://brew.sh)

- Used to install almost everything else

### [Powerlevel10k](https://github.com/romkatv/powerlevel10k)

- Very nice prompt
- Install with homebrew

### [fzf](https://github.com/junegunn/fzf)

- Fuzzy finder
- Install with homebrew

### [ripgrep](https://github.com/BurntSushi/ripgrep)

- better `grep`
- Easily search recursively for text
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
- Prefix is \` (backtick)
- I usually use iTerm to handle tmux instead of running it directly. `tmux -CC` starts a session with iTerm.
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

### 4. Install everything listed in the ["Other Tools to Install"](#other-tools-to-install) section
1. Once homebrew is installed, run
```bash
brew install neovim powerlevel10k fzf ripgrep fd lazygit tmux htop miniconda
```
2. zsh-syntax-highlighting and zsh-autosuggestions still need to be cloned

### 5. Configure Neovim
1. Open Neovim and wait for plugins to install.
2. Install LSPs, formatters, and syntaxes by typing `:Setup`.
3. Restart Neovim and type `:checkhealth` to make sure everything is working correctly.

