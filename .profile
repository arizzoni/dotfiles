#!/bin/sh

## XDG Desktop Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Add bin directory to path
PATH=$PATH:~/.local/bin

## Raspberry Pi Pico SDK
export PICO_SDK_PATH="/usr/share/pico-sdk"

## Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

## NPM
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

## Cuda
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

## Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

## Bash

# Bash History
export HISTFILE="$XDG_STATE_HOME/bash_history"

# Don't save duplicate commands
export HISTCONTROL=erasedups:ignoredups:ignorespace

# History size limit (in memory)
export HISTSIZE=1000

# History size limit (on disk)
export HISTFILESIZE=10000

## Python
if [ -x "$(command -v python)" ]; then {
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
    export MYPY_CACHE_DIR="$XDG_CACHE_HOME/mypy"
    export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
    export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
    export PYTHONUSERBASE="$XDG_DATA_HOME/python"
    export IPYTHONDIR="$HOME/.local/share/ipython"
}; fi

## LaTeX
if tex --version | grep -q 'TeX Live'; then {
    export TEXMFHOME="$XDG_DATA_HOME/texmf"
    export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
    export TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-config"
}; fi

## Editors
if [ -x "$(command -v nvim)" ]; then {
    export EDITOR="nvim"              # Export Neovim as global editor
    export MANPAGER="nvim -c ':Man!'" # Use Neovim as manpager
}; elif [ -x "$(command -v vim)" ]; then {
    export EDITOR="vim"              # Export Vim as global editor
    export MANPAGER="vim -c ':Man!'" # Use Vim as manpager
}; else {
    export EDITOR="vi" # Export Vi as global editor
    if [ -x "$(command -v less)" ]; then {
        export MANPAGER="less" # Use Less as manpager if available
    }; fi
}; fi
