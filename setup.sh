#!/bin/bash

# Symlinks: Target -> Destination
declare -A mappings=(
    ["$HOME/git/dots/.bash_profile"]=$HOME/.bash_profile
    ["$HOME/git/dots/.bashrc"]=$HOME/.bashrc
    ["$HOME/git/dots/.gitconfig"]=$HOME/.gitconfig
    ["$HOME/git/dots/alacritty"]=$HOME/.config/alacritty
    ["$HOME/git/dots/fastfetch/"]=$HOME/.config/fastfetch
    ["$HOME/git/dots/lazygit/"]=$HOME/.config/lazygit
    ["$HOME/git/dots/nvim"]=$HOME/.config/nvim
    ["$HOME/git/dots/tmux/.tmux.conf"]=$HOME/.tmux.conf
)

# Dependencies
deps=(
    "azure-cli"
    "bat"
    "eza"
    "fastfetch"
    "fzf"
    "gh"
    "git-delta"
    "go"
    "lazygit"
    "neovim"
    "nodejs"
    "npm"
    "python"
    "ripgrep"
    "screen"
    "starship"
    "tmux"
    "unzip"
    "wget"
    "zoxide"
)

# Install brew if not already installed
if ! command -v brew &>/dev/null; then
    echo "brew could not be found, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

echo "Removing existing files/directories..."
mkdir -p ~/.config
for key in "${!mappings[@]}"; do
    rm -rf ${mappings[$key]}
done

echo "Creating symbolic links..."
for key in "${!mappings[@]}"; do
    ln -sf $key ${mappings[$key]}
done

echo "Installing Dependencies..."
depString=""
for dep in "${deps[@]}"; do
    depString="$depString 
$dep"
done
brew install $depString

# install bat themes
cp -f $HOME/git/dots/bat/themes/* $HOME/.config/bat/themes/
bat cache --clear
bat cache --build

echo "Done!"
