#!/usr/bin/env bash
# ~/.config/bash/.bashrc
# v0.4

# If not running interactively, don't do anything
[[ $- != *i* ]] && return # No need to run the configuration for a script

# PSX Prompts
if [[ -f $HOME/.bash_prompt ]] ; then {
    source "$HOME/.bash_prompt"
} fi

# Core Utility Aliases
if [[ -x "$(command -v  eza)" ]] ; then { # If eza is installed prefer over ls
        alias ls="eza --long --no-quotes --sort=extension \
                --group-directories-first --time-style=long-iso \
                --git-ignore --git --git-repos --level=1"
        alias la="eza --long --no-quotes --almost-all --sort=extension \
                --group-directories-first --time-style=long-iso \
                --git --git-repos --level=1"
        alias tree="eza --tree --level 2"
} else {
        alias ls="ls --color=auto -g --time-style=long-iso --sort=extension \
                --group-directories-first"
        alias la="ls --almost-all --color=auto -g --time-style=long-iso \
                --sort=extension --group-directories-first"
} fi

if [[ -x "$(command -v  bat)" ]] ; then { # If bat is installed prefer over ls
        alias cat="bat --theme=ansi"
} else {
        alias cat="cat --number-nonblank"
} fi

# Neovide Alias
if [[ -x "$(command -v neovide)" ]] ; then {
        alias neovide="neovide --no-fork"
} fi

# IPython Alias
if [[ -d "~/.local/share/python/ipython/bin/" ]]; then {
        alias ipython="source ~/.local/share/python/ipython/bin/activate; \
                python -m IPython; \
                deactivate;"
} fi
