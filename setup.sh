#!/bin/bash

# Change to the directory of this script
cd "$(dirname "$0")"

declare -A mappings=(
    [$HOME/git/dots/nvim]=$HOME/.config/nvim
    [$HOME/git/dots/.gitconfig]=$HOME/.gitconfig
    [$HOME/git/dots/alacritty]=$HOME/.config/alacritty
    [$HOME/git/dots/hypr]=$HOME/.config/hypr
    [$HOME/git/dots/.bashrc]=$HOME/.bashrc
    [$HOME/git/dots/waybar]=$HOME/.config/waybar
)

echo "Removing existing files/directories..."
for key in "${!mappings[@]}"; do
    rm -rf ${mappings[$key]}
done

echo "Creating symbolic links..."
for key in "${!mappings[@]}"; do
    ln -sf $key ${mappings[$key]}
done

echo "Done!"
