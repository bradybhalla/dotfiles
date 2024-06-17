#!/bin/bash

# choose which set of configuration files to use
ITEMS=(.config/nvim .config/alacritty .zshrc .zsh_aliases .p10k.zsh .tmux.conf)
# ITEMS=(.config/nvim .tmux.conf)

# create backup folder
if [ -d backup ]; then
    # backup already exists
    read -p "Backup already exists and may be overwritten, continue? (y/n): " confirm
    if ! [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] ; then
        echo "Exiting..."
        exit 1
    fi
    rm -rf backup
fi
mkdir backup

for item in "${ITEMS[@]}"; do
    if [[ -e "$HOME/$item" ]]; then
        # item already exists
        echo "$item exists, saving copy."
        mkdir -p $(dirname "backup/$item")
        mv "$HOME/$item" "backup/$item"
    fi

    mkdir -p $(dirname "$HOME/$item")
    cp -r "$item" "$HOME/$item"
done

echo "Done!"
