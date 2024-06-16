#!/bin/bash

# Symlinks: Target -> Destination
declare -A mappings=(
	["$HOME/git/dots/.bash_profile"]=$HOME/.bash_profile
	["$HOME/git/dots/.bashrc"]=$HOME/.bashrc
	["$HOME/git/dots/.gitconfig"]=$HOME/.gitconfig
	["$HOME/git/dots/tmux/.tmux.conf"]=$HOME/.tmux.conf
	["$HOME/git/dots/alacritty"]=$HOME/.config/alacritty
	["$HOME/git/dots/lazygit/"]=$HOME/.config/lazygit
	["$HOME/git/dots/nvim"]=$HOME/.config/nvim
	["$HOME/git/dots/fastfetch"]=$HOME/.config/fastfetch
)

# Dependencies
deps=(
	"alacritty"
	# "azure-cli-bin"
	"bash-completion"
	"bat"
	"bat"
	# "bicep-bin"
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
	# "powershell-bin"
	"python"
	"ripgrep"
	"starship"
	"unzip"
	"wget"
	"zoxide"
)

echo "Removing existing files/directories..."
for key in "${!mappings[@]}"; do
	rm -rf ${mappings[$key]}
done

echo "Creating symbolic links..."
for key in "${!mappings[@]}"; do
	ln -sf $key ${mappings[$key]}
done

echo "Installing Dependencies..."
# enable coprs & third party repos
sudo dnf install 'dnf-command(copr)'
sudo dnf install 'dnf-command(config-manager)'
sudo dnf copr enable atim/lazygit -y
sudo dnf copr enable atim/starship -y
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo

depString=""
for dep in "${deps[@]}"; do
	depString="$depString $dep"
done
sudo dnf install --assumeyes $depString

# install bat themes
cp -f $HOME/git/dots/bat/themes/* $HOME/.config/bat/themes/
bat cache --clear
bat cache --build

echo "Done!"
