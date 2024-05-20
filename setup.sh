#!/bin/bash

# Symlinks: Target -> Destination
declare -A mappings=(
	["$HOME/git/dots/.bash_profile"]=$HOME/.bash_profile
	["$HOME/git/dots/.bashrc"]=$HOME/.bashrc
	["$HOME/git/dots/.gitconfig"]=$HOME/.gitconfig
	["$HOME/git/dots/.tmux.conf"]=$HOME/.tmux.conf
	["$HOME/git/dots/alacritty"]=$HOME/.config/alacritty
	["$HOME/git/dots/lazygit/"]=$HOME/.config/lazygit
	["$HOME/git/dots/nvim"]=$HOME/.config/nvim
)

# Dependencies
deps=(
	"alacritty"
	"azure-cli-bin"
	"bash-completion"
	"bat"
	"bat"
	"bicep-bin"
	"eza"
	"fastfetch"
	"fuse2"
	"fuse2fs"
	"fuse3"
	"fzf"
	"github-cli"
	"go"
	"lazygit"
	"neovim-git"
	"nodejs"
	"npm"
	"powershell-bin"
	"python"
	"ripgrep"
	"screen"
	"starship"
	"ttf-jetbrains-mono-nerd"
	"unzip"
	"wget"
	"zoxide"
)

# Install yay if not already installed
if ! command -v yay &>/dev/null; then
	echo "yay could not be found, installing..."
	sudo pacman -S --noconfirm git base-devel

	# Clone the yay repository
	git clone https://aur.archlinux.org/yay-bin
	cd yay-bin
	makepkg -si --noconfirm

	# Clean up
	cd ..
	rm -rf yay-bin
fi
yay -Syu --noconfirm

# Change to the directory of this script
cd "$(dirname "$0")"

echo "Removing existing files/directories..."
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
	depString="$depString $dep"
done
yay -S --noconfirm --needed $depString

echo "Done!"
