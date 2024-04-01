#!/usr/bin/env bash

# XDG Desktop Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc":"$XDG_CONFIG_HOME/gtk-1.0/gtkrc.mine"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc":"$XDG_CONFIG_HOME/gtk-2.0/gtkrc.mine"

if [ -x "$(command -v python)" ] ; then {
	export VIRTUAL_ENV_DISABLE_PROMPT=1
	export MYPY_CACHE_DIR="$XDG_CACHE_HOME/mypy"
	export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
	export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
	export PYTHONUSERBASE="$XDG_DATA_HOME/python"
	
	if [ -x "$(command -v ipython)" ] ; then {
		export IPYTHONDIR="$HOME/.local/share/ipython"
	} fi
} fi

if [ -x "$(command -v rlwrap)" ] ; then {
	export RLWRAP_HOME="$XDG_DATA_HOME/rlwrap"
} fi

if tex --version | grep -q 'TeX Live' ; then {
	export TEXMFHOME="$XDG_DATA_HOME/texmf"
	export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
	export TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-config"
} fi

if [ -x "$(command -v w3m)" ] ; then {
	export W3M_DIR="$XDG_STATE_HOME/w3m"
} fi

# Add bin directory to path
PATH=$PATH:~/.local/bin

# Bash History
export HISTFILE="$HOME/.cache/.bash_history"
export HISTCONTROL=ignoredups # Don't save duplicate commands
export HISTSIZE=2000 # History size limit (in memory)
export HISTFILESIZE=2000 # History size limit (on disk)

# Editors
if [[ -x "$(command -v nvim)" ]] ; then {
    export EDITOR="nvim" # Export Neovim as global editor
    export MANPAGER="nvim -c ':Man!'" # Use Neovim as manpager
} fi

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
