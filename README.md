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

## Usage

### NixOS

- Make sure that "system.stateVersion" of the configuration you want to use matches the one at "/etc/nixos/configuration.nix"
- Clone this repo as "~/dotfiles"
  ```sh
  git clone https://github.com/bradybhalla/dotfiles.git ~/dotfiles
  ```
- Generate the hardware configuration 
  ```sh
  sudo nixos-generate-config --show-hardware-config > hosts/<host>/hardware-configuration.nix
  ```
- Rebuild system
  ```sh
  sudo nixos-rebuild switch --flake .#<host>
  ```
- Set up home manager
  ```sh
  home-manager switch --flake .#<user>@<host>`
  ```

### MacOS

- Install [Nix](https://nixos.org/download/) and [Homebrew](https://brew.sh) (see websites for instructions)
- Clone this repo as "~/dotfiles"
  ```sh
  git clone https://github.com/bradybhalla/dotfiles.git ~/dotfiles
  ```
- Rebuild system
  ```sh
  sudo darwin-rebuild switch --flake .#<host>
  ```
- Set up home manager
  ```sh
  home-manager switch --flake .#<user>@<host>`
  ```

### Without Nix

Install programs with your package manager of choice, then copy files from "dotfiles/" into your home directory. Note that this will be missing dotfiles for programs that are configured entirely through home manager.
