# dotfiles

My setup for 90% of everything I do on a computer.

## Components

### Editors
- [Neovim](https://neovim.io): configured with LSP, autocomplete, telescope,
  LaTeX, and more.
- [Spacemacs](https://www.spacemacs.org/)

### Window/shortcut managers
- [Aerospace](https://github.com/nikitabobko/AeroSpace): tiling window manager
- [Rectangle](https://rectangleapp.com/): if you don't want a tiling window
  manager
- [skhd](https://github.com/koekeishiya/skhd): used to quickly open apps

### Terminal/shell
- [Alacritty](https://alacritty.org/): download MesloLGS Nerd Font if needed
- [tmux](https://github.com/tmux/tmux): prefix `Ctrl-S`
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k): zsh prompt
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  and [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions):
  clone into `~/bin`

### Other helpful shell tools
- [fzf](https://github.com/junegunn/fzf): fuzzy finder
- [zoxide](https://github.com/ajeetdsouza/zoxide): `cd` alternative
- [lazygit](https://github.com/jesseduffield/lazygit): git ui
- [ripgrep](https://github.com/BurntSushi/ripgrep): `grep` alternative
- [fd](https://github.com/sharkdp/fd): `find` alternative
- [htop](https://htop.dev): process viewer
- [miniconda](https://docs.conda.io/projects/miniconda/en/latest/): Python
  package and environment manager

## Setup

### Setup for MacOS

Install apps and tools listed above (most can be done with
[Homebrew](https://brew.sh)). Run `./configure.sh` to put config files in the
correct locations.

### (Partial) Setup for Other Operating Systems

Homebrew cannot be used, so the tools will have to be installed using other
methods. This can be done by either finding binary releases at the links above
or using a different package manager. Modify `ITEMS` in "configure.sh" to only
contain the installed tools, then run `./configure.sh`.

### Neovim Setup

After installing the tools above and running "configure.sh",
1. Open Neovim and wait for plugins to install.
2. Install language servers, formatters, debuggers. If you don't have them
   already, use `:Mason`.
3. Install common treesitter parsers with `:SetupTreesitter`. Other parsers can
   be installed with `:TSInstall <parser name>`.
3. Restart Neovim and type `:checkhealth` to make sure everything is working
   correctly.
