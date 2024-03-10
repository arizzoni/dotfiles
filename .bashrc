#!/usr/bin/env bash
# ~/.config/bash/.bashrc
# v0.4

# If not running interactively, don't do anything
[[ $- != *i* ]] && return # No need to run the configuration for a script

# PSX Prompts
if [[ -f $HOME/.bash_prompt ]] ; then {
    source "$HOME/.bash_prompt"
} fi

# Bash Completions
if [[ -f /usr/share/bash-completion/bash_completion ]]; then {
        source '/usr/share/bash-completion/bash_completion'
} fi

# Aliases
source "$HOME/.aliases"

# Fastfetch
if [[ -x "$(command -v fastfetch)" ]] ; then {
        fastfetch -s Title:OS:Kernel:Shell:Break:Colors:Break --logo arch_small
} fi
