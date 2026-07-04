#!/usr/bin/env bash

set -euo pipefail

# Require HOST and USER to be passed in
: "${HOST:?HOST is not set}"
: "${USER:?USER is not set}"

export NIX_CONFIG="extra-experimental-features = nix-command flakes"

DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles..."
  nix run nixpkgs#git -- clone https://github.com/bradybhalla/dotfiles.git "$DOTFILES_DIR"
fi
cd "$DOTFILES_DIR"

echo "Generating hardware config..."
sudo nixos-generate-config --show-hardware-config > "hosts/$HOST/hardware-configuration.nix"

echo "Building NixOS config..."
sudo --preserve-env=NIX_CONFIG nixos-rebuild switch --flake ".#$HOST"

echo "Building home manager config..."
nix run github:nix-community/home-manager -- switch --flake ".#$USER@$HOST"

echo "Done"
