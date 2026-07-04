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

### NixOS
Fill in <host> and <user> and then run the following:
```sh
export HOST=pc-brady
export USER=bradybhalla
export NIX_CONFIG="extra-experimental-features = nix-command flakes"
nix run nixpkgs#git -- clone https://github.com/bradybhalla/dotfiles.git ~/dotfiles
cd ~/dotfiles
sudo nixos-generate-config --show-hardware-config > "hosts/$HOST/hardware-configuration.nix"
sudo --preserve-env=NIX_CONFIG nixos-rebuild -- switch --flake ".#$HOST"
nix run github:nix-community/home-manager -- switch --flake ".#$USER@$HOST"
```

### MacOS
Install Nix, fill in HOST and USER, and then run the following:
```sh
export HOST=macbook-pro-brady
export USER=bradybhalla
export NIX_CONFIG="extra-experimental-features = nix-command flakes"
nix run nixpkgs#git -- clone https://github.com/bradybhalla/dotfiles.git ~/dotfiles
cd ~/dotfiles
sudo --preserve-env=NIX_CONFIG nix run github:nix-darwin/nix-darwin#darwin-rebuild -- switch --flake ".#$HOST"
nix run github:nix-community/home-manager -- switch --flake ".#$USER@$HOST"
```

### Without Nix
Install programs with your package manager of choice, then copy dotfiles from "dotfiles/" into your home directory.
