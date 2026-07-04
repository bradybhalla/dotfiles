# dotfiles

My configuration for 90% of everything I do on a computer.

## Some tools I use

- [Neovim](https://neovim.io): main text editor
- [Spacemacs](https://www.spacemacs.org/): for Org mode
- [Hyprland](https://hypr.land/) or [Aerospace](https://github.com/nikitabobko/AeroSpace): tiling window manager
- [Alacritty](https://alacritty.org/): terminal emulator
- [lazygit](https://github.com/jesseduffield/lazygit): git ui
- [zoxide](https://github.com/ajeetdsouza/zoxide): `cd` alternative
- [fzf](https://github.com/junegunn/fzf): fuzzy finder
- ...

## Setup

```sh
# only if on nixos
sudo nixos-rebuild switch --flake .

# only if on macos
sudo nix-darwin switch --flake .

home-manager switch --flake .
```

### Karabiner Elements Instructions

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
