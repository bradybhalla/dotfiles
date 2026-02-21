#!/bin/bash

# choose which set of configuration files to use
ITEMS=( .config/nvim
        .config/tmux
        .config/alacritty
        .config/skhd
        .spacemacs
        .zshrc
        .zsh_aliases
        .p10k.zsh
        .aerospace.toml
        .newsboat/config
    )

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/backup"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

# create backup folder if needed
if [ -d "$BACKUP_DIR" ]; then
    echo "Backup already exists, delete it and try again"
    exit 1
fi
mkdir -p "$BACKUP_DIR"

for item in "${ITEMS[@]}"; do
    if [[ -L "$HOME/$item" ]]; then
        # remove existing symlinks
        rm "$HOME/$item"
    elif [[ -f "$HOME/$item" || -d "$HOME/$item" ]]; then
        # backup item if it exists
        echo "$item exists, saving backup"
        mkdir -p $(dirname "$BACKUP_DIR/$item")
        mv "$HOME/$item" "$BACKUP_DIR/$item"
    fi

    mkdir -p $(dirname "$HOME/$item")
    ln -s "$DOTFILES_DIR/$item" "$HOME/$item"
done

echo "Done!"
