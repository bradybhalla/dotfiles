# dotfiles

My setup for 90% of everything I do on a computer.

## Components

- [Neovim](https://neovim.io): The best text editor. This configuration has LSP, autocomplete, telescope, a LaTeX setup, and more.
- [tmux](https://github.com/tmux/tmux): Terminal multiplexer. Prefix `Ctrl-S`.
- [Alacritty](https://alacritty.org/): A (blazingly?!) fast terminal emulator. Keybindings for use with tmux. Install MesloLGS Nerd Font if needed.
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k): Very nice zsh prompt.
- [lazygit](https://github.com/jesseduffield/lazygit): Git UI for the terminal. This saves me so much time.
- [Catppuccin](https://catppuccin.com/): The color scheme I use for everything I can (frappé is the best flavor).
- [skhd](https://github.com/koekeishiya/skhd): Quickly open apps.
- Various shell utils: [fzf](https://github.com/junegunn/fzf) (fuzzy finder), [ripgrep](https://github.com/BurntSushi/ripgrep) (better grep), [fd](https://github.com/sharkdp/fd) (better find), [htop](https://htop.dev) (interactive process viewer), [zoxide](https://github.com/ajeetdsouza/zoxide) (better cd), [miniconda](https://docs.conda.io/projects/miniconda/en/latest/) (Python package and version manager), [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) (highlight valid/invalid commands and files), [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) (show command completion)

## Setup
### Setup for MacOS
Clone this repository. Install [Alacritty](https://alacritty.org/) and [Homebrew](https://brew.sh) using instructions on their websites. Run
```
brew install neovim powerlevel10k fzf ripgrep fd lazygit tmux htop zoxide miniconda koekeishiya/formulae/skhd
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/bin/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/bin/zsh-autosuggestions
./configure.sh
```

### (Partial) Setup for Other Operating Systems

Homebrew cannot be used, so the tools will have to be installed using other methods. This can be done by either finding binary releases at the links above or using a different package manager. Modify `ITEMS` in "configure.sh" to only contain the installed tools, then run `./configure.sh`.

### Neovim Setup
After installing the tools above and running "configure.sh",
1. Open Neovim and wait for plugins to install.
2. Install language servers, formatters, debuggers. If you don't have them already, use `:Mason`.
3. Install common treesitter parsers I use with `:SetupTreesitter`. Other parsers can be installed with `:TSInstall <parser name>`.
3. Restart Neovim and type `:checkhealth` to make sure everything is working correctly.
