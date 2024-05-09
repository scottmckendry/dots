#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Functions
function lsPretty() {
	echo ""
	eza -a -l --header --icons --hyperlink --time-style relative $1
	echo ""
}

# Check for updates with yay
function checkUpdates() {
	updates=$(yay -Qu | wc -l)
	if [ $updates -gt 1 ]; then
		sed -i "s/SOFTWARE_UPDATE_AVAILABLE=.*/SOFTWARE_UPDATE_AVAILABLE=\"\ \"/" ~/.bash_profile
	else
		sed -i "s/SOFTWARE_UPDATE_AVAILABLE=.*/SOFTWARE_UPDATE_AVAILABLE=\"\"/" ~/.bash_profile
	fi
}

# Check for updates in dotfiles
function checkDotfilesUpdate() {
	cd ~/git/dots
	updates=$(git status | grep -q "behind" && echo "true" || echo "false")
	if $updates; then
		sed -i "s/DOTFILES_UPDATE_AVAILABLE=.*/DOTFILES_UPDATE_AVAILABLE=\"󱤜 \"/" ~/.bash_profile
	else
		sed -i "s/DOTFILES_UPDATE_AVAILABLE=.*/DOTFILES_UPDATE_AVAILABLE=\"\"/" ~/.bash_profile
	fi
}

# Update software using apt
function updateSoftware() {
	yay -Syu --noconfirm
	sed -i "s/SOFTWARE_UPDATE_AVAILABLE=.*/SOFTWARE_UPDATE_AVAILABLE=\"\"/" ~/.bash_profile
	. ~/.bash_profile
}

# Pull in latest dotfile updates and run setup
function updateDotfiles() {
	currentDir=$(pwd)
	cd ~/git/dots
	git pull
	./setup.sh
	cd $currentDir
	sed -i "s/DOTFILES_UPDATE_AVAILABLE=.*/DOTFILES_UPDATE_AVAILABLE=\"\"/" ~/.bash_profile
	. ~/.bash_profile
}

# Environment variables
. ~/.bash_profile

# Aliases
alias cd='z'
alias cdi='zi'
alias cat='batcat'
alias up='updateDotfiles'
alias us='updateSoftware'
alias ls=lsPretty

# Enable bash completion in interactive shells
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Load NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Setup prompt
eval "$(starship init bash)"
eval "$(zoxide init bash)"

(checkUpdates &)
(checkDotfilesUpdate &)

PROMPT_COMMAND='source ~/.bash_profile;'$PROMPT_COMMAND
