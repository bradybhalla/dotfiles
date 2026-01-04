# dotfiles

My setup for 90% of everything I do on a computer.

## Components

### Editors

- [Neovim](https://neovim.io): configured with LSP, autocomplete, telescope,
  LaTeX, and more.
- [Spacemacs](https://www.spacemacs.org/): mostly just the base config

### Window managers / Keyboard shortcuts

- [Aerospace](https://github.com/nikitabobko/AeroSpace): tiling window manager
- [Rectangle](https://rectangleapp.com/): if you don't want a tiling window
  manager
- [skhd](https://github.com/koekeishiya/skhd): custom keyboard shortcuts, used
  to quickly open apps
- [Karabiner Elements](https://karabiner-elements.pqrs.org): bind `Caps Lock` to
  mod-tap `Ctrl`/`Esc`

### Terminal / Shell

- [Alacritty](https://alacritty.org/): download MesloLGS Nerd Font if needed
- [tmux](https://github.com/tmux/tmux): prefix `Ctrl-S`
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k): zsh prompt
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  and [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions):
  clone into `~/bin`

### Other helpful tools/apps

- [Newsboat](https://newsboat.org/index.html): terminal RSS feed reader
- [fzf](https://github.com/junegunn/fzf): fuzzy finder
- [zoxide](https://github.com/ajeetdsouza/zoxide): `cd` alternative
- [lazygit](https://github.com/jesseduffield/lazygit): git ui
- [ripgrep](https://github.com/BurntSushi/ripgrep): `grep` alternative
- [fd](https://github.com/sharkdp/fd): `find` alternative
- [htop](https://htop.dev): process viewer
- [miniconda](https://docs.conda.io/projects/miniconda/en/latest/): Python
  package and environment manager

## Setup

### Dotfiles Setup

Install apps and tools listed above (most can be done with
[Homebrew](https://brew.sh) on macOS). Modify `ITEMS` in "configure.sh" to only
contain installed tools. Run `./configure.sh` to put config files in the correct
locations.

### Neovim Setup

After installing the tools above and running `./configure.sh`,
1. Open Neovim and wait for plugins/treesitter parsers to install.
2. Install language servers, formatters, debuggers. If you don't have them
   already, use `:Mason`.
3. Restart Neovim and type `:checkhealth` to make sure everything is working
   correctly.

### Karabiner Elements Setup

Download and install the Karabiner Elements app. Add a "Complex Modification" with the following contents:
```json
{
    "description": "Tap Caps Lock for ESC or Hold for Control",
    "manipulators": [
        {
            "from": {
                "key_code": "caps_lock",
                "modifiers": { "optional": ["any"] }
            },
            "to": [
                {
                "key_code": "left_control",
                "lazy": true
                }
            ],
            "to_if_alone": [{ "key_code": "escape" }],
            "type": "basic"
        }
    ]
}
```
