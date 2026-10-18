#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

###############################################################################
# Shell options
###############################################################################
bindkey -v
export TERM=xterm-256color
export KEYTIMEOUT=1
export CLICOLOR
export EDITOR=nvim
export VISUAL=nvim
