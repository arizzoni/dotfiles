#!/usr/bin/env bash

# XDG Desktop Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/state"
export XDG_STATE_HOME="$HOME/.local/state"

# Bash History
export HISTFILE="$HOME/.cache/.bash_history"
export HISTCONTROL=ignoredups # Don't save duplicate commands
export HISTSIZE=2000 # History size limit (in memory)
export HISTFILESIZE=2000 # History size limit (on disk)

source "$HOME/.env"

# Editors
if [[ -x "$(command -v nvim)" ]] ; then {
    export EDITOR="nvim" # Export Neovim as global editor
    export MANPAGER="nvim -c ':Man!'" # Use Neovim as manpager
} fi

# IPython local dir
export IPYTHONDIR="$HOME/.local/share/ipython"

# Add bin directory to path
PATH=$PATH:~/.local/bin

# Bash Shell Options
shopt -s checkwinsize
shopt -s direxpand
shopt -s dotglob
shopt -s globstar
shopt -s histappend
shopt -s histreedit
shopt -s histverify
shopt -s hostcomplete
shopt -s no_empty_cmd_completion
shopt -s nocaseglob
shopt -s progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s sourcepath
set -o braceexpand
set -o noclobber

# bashrc 
if [[ -f $HOME/.bashrc ]] ; then {
    source "$HOME/.bashrc"
} fi
