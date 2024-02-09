#!/usr/bin/env bash
# ~/.config/bash/.bash_profile
# v0.1

# Bash History
export HISTFILE="$HOME/.cache/.bash_history"
export HISTCONTROL=ignoredups # Don't save duplicate commands
export HISTSIZE=2000 # History size limit (in memory)
export HISTFILESIZE=2000 # History size limit (on disk)

# Editors
export EDITOR="nvim" # Export Neovim as global editor
export MANPAGER="nvim -c ':Man!'" # Use Neovim as manpager

# IPython local dir
export IPYTHONDIR="$HOME/.local/share/ipython"

# Add bin directory to path
PATH=$PATH:~/.dotfiles/bin

# Bash Shell Options
shopt -s autocd
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

# Bash Completions - Sourced in etc/bash.bashrc or wherever
if [[ -f /usr/share/bash-completion/bash_completion ]]; then {
        source /usr/share/bash-completion/bash_completion
} fi

# Wal Colors
if [[ -x "$(command -v wal)" ]] ; then
    wal -Rnq
    pywalfox update
    zathura-pywal -a 0.8 &>/dev/null
fi

# bashrc 
if [[ -f $HOME/.bashrc ]] ; then {
    source "$HOME/.bashrc"
} fi
