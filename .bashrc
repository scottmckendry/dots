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

# Environment variables
export STARSHIP_CONFIG=~/git/dots/starship/starship.toml

# Aliases
alias cd='z'
alias cdi='zi'
alias ls=lsPretty

# Setup prompt
eval "$(starship init bash)"
eval "$(zoxide init bash)"
