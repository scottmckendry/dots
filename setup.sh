#!/bin/bash

# Change to the directory of this script
cd "$(dirname "$0")"

echo "Removing existing files/directories..."
if [ -d ~/.config/nvim ]; then
  echo "Removing ~/.config/nvim"
  rm -rf ~/.config/nvim
fi

if [ -f ~/.gitconfig ]; then
  echo "Removing ~/.gitconfig"
  rm ~/.gitconfig
fi

echo "Creating symbolic links..."
ln -sf ~/git/dots/nvim ~/.config/nvim
ln -sf ~/git/dots/.gitconfig ~/.gitconfig
