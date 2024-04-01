#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return # No need to run the configuration for a script

## PSX Prompts

# Define text styles
_bold=$(tput bold)
_normal=$(tput sgr0)
_italic=$(tput sitm)
_remove_italic=$(tput ritm)

# Define text foreground colors
# fg_color0=$(tput setaf 0) # Don't need black foreground color
_fg_color1=$(tput setaf 1)
_fg_color2=$(tput setaf 2)
_fg_color3=$(tput setaf 3)
_fg_color4=$(tput setaf 4)
_fg_color5=$(tput setaf 5)
_fg_color6=$(tput setaf 6)
_fg_color7=$(tput setaf 7)

function virtualenv_info(){
        if [[ -n "$VIRTUAL_ENV" ]]; then {
                echo " (venv:\[${_italic}\]${VIRTUAL_ENV##*/}\[${_remove_italic}\])"
        } fi
}

function git_info(){
        if git branch &> /dev/null; then {
                echo " (git:\[${_italic}\]$(git rev-parse --abbrev-ref HEAD)\[${_remove_italic}\])"
        } fi
}

function exit_status(){
        if [[ ! $1 == 0 ]] ; then {
                echo "⨉ "
        } fi
}

function set_prompts(){
        exit_code=$? # Collect previous exit code for exit_status()

        # NOTE: "\[" and "\]" are used so that bash can calculate the number
        # of printed characters so that the prompt doesn't do strange things
        # when editing the entered text. All nonprinted characters should be
        # escaped in this manner to avoid misbehavior.
        
        PS0='' # Not used - displayed after each command, before any output
        PS1="\[${_fg_color1}${_bold}\]$(exit_status $exit_code)\[${_fg_color2}\]\u\[${_normal}\]@\[${_bold}${_fg_color3}\]\h\[${_normal}\] \[${_fg_color4}\]\w\[${_fg_color5}\]$(git_info)\[${_fg_color6}\]$(virtualenv_info) \[${_fg_color7}${_italic}\]\$\[${_normal}\] " # Primary output displayed before command
        PS2="\[${_fg_color1}${_bold}\]$(exit_status exit_code)\[${_fg_color2}\]\u\[${_normal}\] \[${_fg_color7}${_italic}\]\$\[${_normal}\] " # Secondary prompt when a command needs more input
        PS3='' # Not used - bash select interactive menus
        PS4='' # Not used - bash debug
}

PROMPT_COMMAND=set_prompts

## Bash Completions
if [[ -f /usr/share/bash-completion/bash_completion ]]; then {
        source '/usr/share/bash-completion/bash_completion'
} fi

# Start a tmux session
# if [[ -x "$(command -v tmux)" ]] && [[ -n "$PS1" ]] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [[ -z "$TMUX" ]] ; then {
#         exec tmux new
# } fi

## Wal
if [[ -f "$HOME/.cache/wal/sequences" ]] ; then {
        (cat "$HOME/.cache/wal/sequences" &)
} fi

## Aliases

# ls
if [[ -x "$(command -v  eza)" ]] ; then { # If eza is installed prefer over ls
        alias ls="eza --long --no-quotes --sort=extension \
                --group-directories-first --time-style=long-iso \
                --git-ignore --git --git-repos --level=1"
        alias la="eza --long --no-quotes --almost-all --sort=extension \
                --group-directories-first --time-style=long-iso \
                --git --git-repos --level=1"
        alias tree="eza --tree --almost-all --sort=extension \
                --group-directories-first --level=2"
} else {
        alias ls="ls --color=auto -g --time-style=long-iso --sort=extension \
                --group-directories-first"
        alias la="ls --almost-all --color=auto -g --time-style=long-iso \
                --sort=extension --group-directories-first"
} fi

# cd
change_dir() {
# Change default behavior by calling the ls alias after changing directories.
# If python is installed, manage virtual environment activation automatically.
        _dir="$*"

        if [[ $# -lt 1 ]] ; then {
                _dir=$HOME
        } fi

        builtin cd "${_dir}" && ls
        
        if [[ -x "$(command -v python)" ]] ; then {
        # If python is installed and a parent directory has a virtual
        # environment, then activate it. Otherwise if a virtual environment
        # is active and a parent directory does not contain a virtual
        # environment, then deactivate the active virtual environment.

                for _env_dir in "venv" ".venv" ; do {
                        _current_dir=$(realpath .)
                        _found=""
                        # Recursively search parent directories for _env_dir
                        while [[ -z "$_found" ]] && [[ -n "$_current_dir" ]] ; do {
                                if [[ -e "$_current_dir/$_env_dir" ]] ; then {
                                        _found="$_current_dir/$_env_dir"
                                } fi
                                _current_dir=${_current_dir%/*}
                        } done
                } done

                if [[ -z "$_found" ]] ; then {
                        if [[ -n "${VIRTUAL_ENV+x}" ]] ; then {
                                deactivate
                        } fi
                } else {
                        . "$_found/bin/activate"
                } fi
        } fi
}
alias cd='change_dir'

# cat
if [[ -x "$(command -v  bat)" ]] ; then { # If bat is installed prefer it over cat
        alias cat="bat --theme=ansi"
} else {
        alias cat="cat --number-nonblank"
} fi

# ncmpcpp
if [[ -x "$(command -v ncmpcpp)" ]] ; then {
        alias ncmpcpp="ncmpcpp -s browser --quiet"
} fi

# Editors
if [[ -x "$(command -v nvim)" ]] ; then {
        # Neovide
        if [[ -x "$(command -v neovide)" ]] ; then {
                alias neovide="neovide --no-fork"
        } fi
} fi

# Minicom
if [[ -x "$(command -v minicom)" ]] ; then {
        alias minicom='minicom --color=on \
        --statlinefmt=" Minicom %V | %b | %T | %D "'
} fi

# IPython
if [[ -d "$HOME/.local/share/python/ipython" ]]; then {
        alias ipython=". ~/.local/share/python/ipython/bin/activate \
        && ipython --no-banner; deactivate; echo;"
} fi

# Clock
if [[ -x "$(command -v toilet)" ]] ; then {
        alias clock='watch -tc -n0.1 "tput setaf 001 ; date +%r \
                | toilet -f smmono12 -W -t -F crop -F border ; tput sgr0"'
} fi

# Pacdiff
if [[ -x "$(command -v pacdiff)" ]] ; then {
        alias pacdiff='DIFFPROG=nvim pacdiff'
} fi

# Fzy
if [[ -x "$(command -v fzy)" ]] ; then {
        if [[ -x "$(command -v fd)" ]] ; then {
                alias fzf='fd . | fzy'
        } else {
                alias fzf='find . | fzy'
        } fi
} fi

# Fastfetch
if [[ -x "$(command -v fastfetch)" ]] ; then {
        alias fastfetch="fastfetch -s Title:OS:Kernel:Shell:Break:Colors:Break --logo arch_small"
        command fastfetch -s Title:OS:Kernel:Shell:Break:Colors:Break --logo arch_small
} fi


