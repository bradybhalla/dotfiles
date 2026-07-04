# dotfiles

My configuration for 90% of everything I do on a computer.
- "dotfiles/" contains dotfiles for each program
- "modules/home/" contains components that home-manager can load
- "hosts/" contains system-level configurations for each system. These can load components from "modules/nixos/"

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

On NixOS, first make sure the correct "hardware-configuration.nix" file is in "hosts/<host>/". If needed you can regenerate it with `nixos-generate-config --show-hardware-config`. Run
```sh
sudo nixos-rebuild --extra-experimental-features "nix-command flakes" -- switch --flake .#<host>
```

On MacOS, run
```sh
sudo nix run nix-darwin/master#darwin-rebuild --extra-experimental-features "nix-command flakes" -- switch --flake .#<host>
```

Finally, regardless of the operating system, set up home manager with
```sh
sudo nix run home-manager/master#home-manager -- switch --flake .#<user>@<host>
```

After setting everything up you can rebuild by running
- `sudo nixos-rebuild switch --flake .#<host>` (NixOS system)
- `sudo darwin-rebuild switch --flake .#<host>` (MacOS system)
- `home-manager switch --flake .#<user>@<host>` (home manager)
