#!/usr/bin/env bash

set -euo pipefail

# require HOST and USER to be passed in
: "${HOST:?HOST is not set}"
: "${USER:?USER is not set}"

# prompt for sudo
sudo -v

export NIX_CONFIG="extra-experimental-features = nix-command flakes"

DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles..."
  nix run nixpkgs#git -- clone https://github.com/bradybhalla/dotfiles.git "$DOTFILES_DIR"
fi
cd "$DOTFILES_DIR"

echo "Building nix-darwin config..."
sudo -H --preserve-env=NIX_CONFIG \
  nix run github:nix-darwin/nix-darwin#darwin-rebuild -- switch --flake ".#$HOST"

echo "Building home manager config..."
nix run github:nix-community/home-manager -- switch --flake ".#$USER@$HOST"

echo "Done"
