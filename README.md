# dotfiles

My setup for 90% of everything I do on a computer.

## Main Components

### Editors

- [Neovim](https://neovim.io): main text editor
- [Spacemacs](https://www.spacemacs.org/): for Org mode. Need to install manually since setup instructions just install Emacs

### Window managers / Keyboard shortcuts

- [Aerospace](https://github.com/nikitabobko/AeroSpace): tiling window manager for MacOS. Sometimes acts weird but it's the best I've found so far
- [Rectangle](https://rectangleapp.com/): for when I don't feel like a tiling window manager
- [skhd](https://github.com/koekeishiya/skhd): keyboard shortcuts mainly to open apps I use frequently
- [Karabiner Elements](https://karabiner-elements.pqrs.org): bind `Caps Lock` to mod-tap `Ctrl`/`Esc`. See instructions below

### Shell / terminal

- [Zsh](https://www.zsh.org/): with Powerlevel10k prompt, autosuggestions, syntax highlighting
- [tmux](https://github.com/tmux/tmux): prefix `Ctrl-S`
- [Alacritty](https://alacritty.org/): if only there was image support

### Other helpful tools

- [lazygit](https://github.com/jesseduffield/lazygit): git ui
- [zoxide](https://github.com/ajeetdsouza/zoxide): `cd` alternative
- [fzf](https://github.com/junegunn/fzf): fuzzy finder
- ...


## Setup (with Nix)

For MacOS:
- `home-manager switch --flake .#bradybhalla` to install most programs and dotfiles.
- `brew bundle` to install the rest. I might eventually use nix-darwin instead but probably not.

For Linux:
- Update "flake.nix" and "home.nix" to use the right system, username, and paths before using home-manager.
- Install apps from "Brewfile" another way.


## Karabiner Elements Instructions

Add a "Complex Modification" with the following contents:
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
