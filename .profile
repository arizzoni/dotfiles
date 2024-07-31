#!/bin/sh

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

# Bash
export HISTFILE="$XDG_STATE_HOME/bash_history" # Bash History
export HISTCONTROL=erasedups:ignoredups:ignorespace # Don't save duplicate commands
export HISTSIZE=1000 # History size limit (in memory)
export HISTFILESIZE=10000 # History size limit (on disk)

if [ -x "$(command -v julia)" ] ; then {
	export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
	export JULIAUP_DEPOT_PATH="$XDG_DATA_HOME/julia"
} fi

if [ -x "$(command -v python)" ] ; then {
	export VIRTUAL_ENV_DISABLE_PROMPT=1
	export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
	export MYPY_CACHE_DIR="$XDG_CACHE_HOME/mypy"
	export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
	export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
	export PYTHONUSERBASE="$XDG_DATA_HOME/python"
	export IPYTHONDIR="$HOME/.local/share/ipython"
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

# Editors
if [ -x "$(command -v nvim)" ] ; then {
    export EDITOR="nvim" # Export Neovim as global editor
    export MANPAGER="nvim -c ':Man!'" # Use Neovim as manpager
} fi

# bashrc 
if [ -f "$HOME/.bashrc" ] && [ "$SHELL" = '/usr/bin/bash' ] ; then {
    . "$HOME/.bashrc"
} fi
