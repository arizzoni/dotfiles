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
        alias tree="eza --tree --almost-all --sort=extension --group-directories-first --level 2"
} else {
        alias ls="ls --color=auto -g --time-style=long-iso --sort=extension \
                --group-directories-first"
        alias la="ls --almost-all --color=auto -g --time-style=long-iso \
                --sort=extension --group-directories-first"
} fi

if [[ -x "$(command -v  bat)" ]] ; then { # If bat is installed prefer over cat
        alias cat="bat --theme=ansi"
} else {
        alias cat="cat --number-nonblank"
} fi

if [[ -x "$(command -v fzf)" ]] ; then {
        alias fzf="fzf --multi --scroll-off=4 --layout=reverse-list --color=16"
} fi

# Neovide Alias
if [[ -x "$(command -v neovide)" ]] ; then {
        alias neovide="neovide --no-fork"
} fi

# Minicom Alias
if [[ -x "$(command -v minicom)" ]] ; then {
        alias minicom='minicom --color=on --statlinefmt=" Minicom %V | %b | %T | %D "'
} fi

# IPython Alias
if [[ -d "$HOME/.local/share/python/ipython" ]]; then {
        alias ipython="source ~/.local/share/python/ipython/bin/activate; \
                ipython --no-banner; \
                deactivate;"
} fi

# Neofetch Alias
if [[ -x "$(command -v neofetch)" ]] ; then {
        alias neofetch="neofetch --disable uptime"
} fi
