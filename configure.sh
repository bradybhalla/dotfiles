#!/bin/bash

ROOT="C:\\Users\\brady\\AppData"

# choose which set of configuration files to use
ITEMS=("Local\\nvim" "Roaming\\alacritty")

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
    if [[ -e "$ROOT\\$item" ]]; then
        # item already exists
        echo "$item exists, saving copy."
        mkdir -p $(dirname "backup\\$item")
        mv "$ROOT\\$item" "backup\\$item"
    fi

    mkdir -p $(dirname "$ROOT\\$item")
    cp -r "$item" "$ROOT\\$item"
done

echo "Done!"
