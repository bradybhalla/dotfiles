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

- Make sure that "system.stateVersion" of the configuration you want to use matches the one at "/etc/nixos/configuration.nix".
- Fill in HOST and USER and run
  ```sh
  export HOST=pc-brady
  export USER=bradybhalla
  curl -fsSL https://raw.githubusercontent.com/bradybhalla/dotfiles/main/scripts/setup-nixos.sh | bash
  ```

### MacOS

- Install [Nix](https://nixos.org/download/) and [Homebrew](https://brew.sh)
- Fill in HOST and USER and run
  ```sh
  export HOST=macbook-pro-brady
  export USER=bradybhalla
  curl -fsSL https://raw.githubusercontent.com/bradybhalla/dotfiles/main/scripts/setup-macos.sh | bash
  ```

### Without Nix

Install programs with your package manager of choice, then copy files from "dotfiles/" into your home directory. Note that this will be missing dotfiles for programs that are configured entirely through home manager.
