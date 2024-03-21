#!/usr/bin/env bash

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

if [[ -x "$(command -v tmux)" ]] && [[ -n "$PS1" ]] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [[ -z "$TMUX" ]] ; then {
        exec tmux new
} fi

# Wal
if [[ -f "$HOME/.cache/wal/sequences" ]] ; then {
        (cat "$HOME/.cache/wal/sequences" &)
} fi

# Fastfetch
if [[ -x "$(command -v fastfetch)" ]] ; then {
        fastfetch -s Title:OS:Kernel:Shell:Break:Colors:Break --logo arch_small
} fi

# Aliases
source "$HOME/.aliases"
