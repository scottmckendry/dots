export STARSHIP_CONFIG=~/git/dots/starship/starship.toml
export PATH=$PATH:/usr/local/go/bin
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export DOTFILES_UPDATE_AVAILABLE=""
export SOFTWARE_UPDATE_AVAILABLE=""
export BAT_CONFIG_DIR=~/git/dots/bat
if [ -z "$BASHRC_LOADED" ]; then
	if [ -f ~/.bashrc ]; then
		source ~/.bashrc
	fi
	export BASHRC_LOADED=1
fi
