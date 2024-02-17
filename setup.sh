#!/bin/bash

# Change to the directory of this script
cd "$(dirname "$0")"

declare -A mappings=(
	["$HOME/git/dots/nvim"]=$HOME/.config/nvim
	["$HOME/git/dots/.gitconfig"]=$HOME/.gitconfig
	["$HOME/git/dots/alacritty"]=$HOME/.config/alacritty
	["$HOME/git/dots/.bashrc"]=$HOME/.bashrc
)

echo "Removing existing files/directories..."
for key in "${!mappings[@]}"; do
	rm -rf ${mappings[$key]}
done

echo "Creating symbolic links..."
for key in "${!mappings[@]}"; do
	ln -sf $key ${mappings[$key]}
done

echo "Adding PPAs..."
sudo add-apt-repository -y ppa:neovim-ppa/unstable

echo "Installing Dependencies..."
sudo apt update
sudo apt install -y alacritty neovim python3 python3-venv fzf ripgrep bat exa

if ! [ -x "$(command -v go)" ]; then
	rm -rf /usr/local/go
	GO_VERSION=$(curl -s "https://go.dev/VERSION?m=text" | head -n 1)
	echo "GO_VERSION=$GO_VERSION"
	echo "Installing Golang..."
	curl -Lo go.tar.gz "https://golang.org/dl/$GO_VERSION.linux-amd64.tar.gz"
	sudo tar -C /usr/local -xzf go.tar.gz
	rm go.tar.gz
fi

if ! [ -x "$(command -v lazygit)" ]; then
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	sudo tar -C /usr/local/bin -xzf lazygit.tar.gz
	rm lazygit.tar.gz
fi

if ! [ -x "$(command -v starship)" ]; then
	echo "Installing Starship..."
	curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

if ! [ -x "$(command -v zoxide)" ]; then
	echo "Installing Zoxide..."
	curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

if ! [ -x "$(command -v node)" ]; then
	echo "Installing NodeJS..."
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
	nvm install --lts
fi

if ! fc-list | grep -q "JetBrainsMono"; then
	echo "Installing JetBrainsMono Nerd Font"
	if [ ! -d ~/.fonts ]; then
		mkdir ~/.fonts
	fi
	curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
	tar -xf JetBrainsMono.tar.xz -C ~/.fonts
	rm JetBrainsMono.tar.xz -f
	fc-cache -f
fi

echo "Done!"
