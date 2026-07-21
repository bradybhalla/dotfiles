# dotfiles

My configuration for 90% of everything I do on a computer.

<img width="3840" height="2160" alt="2026-07-17-000448_hyprshot" src="https://github.com/user-attachments/assets/4d69c014-8fef-43ae-86de-d2963d38fa0d" />
<img width="3840" height="2160" alt="2026-07-15-204556_hyprshot" src="https://github.com/user-attachments/assets/5b3887be-82c6-4c5b-95c3-d6d788ab3386" />
<img width="3840" height="2160" alt="2026-07-15-204045_hyprshot" src="https://github.com/user-attachments/assets/a011828d-47d3-4c34-9b55-7b3aa4e078c3" />

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
  home-manager switch --flake .#<user>@<host>
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
  home-manager switch --flake .#<user>@<host>
  ```

### Without Nix

Install programs with your package manager of choice, then copy files from "dotfiles/" into your home directory. Note that this will be missing dotfiles for programs that are configured entirely through home manager.
