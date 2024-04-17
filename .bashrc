#p!/usr/bin/env bash

## Startup
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Wal colors
if [[ -f "$HOME/.cache/wal/sequences" ]] ; then {
    (cat "$HOME/.cache/wal/sequences")
} fi

## Bash options

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
set -o vi

# Bash Completions
if ! shopt -oq posix ; then {
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then {
        . '/usr/share/bash-completion/bash_completion'
    } elif [[ -f /etc/bash_completion ]] ; then {
        . '/etc/bash_completion'
    } fi
} fi


## PSX Prompts

# Define text styles
function __init_styles(){
    # This code is put into a function so it only runs when called by the
    # __set_prompt() function to keep the scope local to the prompt. The tput
    # command is used to check for the terminal's capabilities, but as it does
    # not support all the required commands, the raw escape codes are used in 
    # some cases.

    # NOTE: Tested on Alacritty, Kitty, Neovide, Zutty, Cool-Retro-Term, Guake,
    # Gnome-Console, and Gnome-Terminal.
    
    if [[ -x "$(command -v tput bold)" ]] ; then {
        __bold=$(tput bold)
        __remove_bold="\e[2m"
    } else {
        __bold=""
        __remove_bold=""
    } fi

    if [[ -x "$(command -v tput sgr0)" ]] ; then {
        __reset=$(tput sgr0)
    } else {
        __reset=""
    } fi

    if [[ -x "$(command -v tput sitm)" ]] ; then {
        __italic=$(tput sitm)
    } else {
        __italic=""
    } fi

    if [[ -x "$(command -v tput ritm)" ]] ; then {
        __remove_italic=$(tput ritm)
    } else {
        __remove_italic=""
    } fi

    if [[ -x "$(command -v tput dim)" ]] ; then {
        __dim=$(tput dim)
        __remove_dim="\e[22m"
    } else {
        __dim=""
        __remove_dim=""
    } fi

    if [[ -x "$(command -v tput tsl)" ]] ; then {
        __status_line=$(tput tsl)
    } else {
        __status_line=""
    } fi

    if [[ -x "$(command -v tput fsl)" ]] ; then {
        __finish_status_line=$(tput fsl)
    } else {
        __finish_status_line=""
    } fi

    # Define text colors
    if [[ -x "$(command -v tput setaf 0)" ]] ; then {
        __fg_color0=$(tput setaf 0)
        __fg_color1=$(tput setaf 1)
        __fg_color2=$(tput setaf 2)
        __fg_color3=$(tput setaf 3)
        __fg_color4=$(tput setaf 4)
        __fg_color5=$(tput setaf 5)
        __fg_color6=$(tput setaf 6)
        __fg_color7=$(tput setaf 7)
        __fg_color8=$(tput setaf 8)
        __fg_color9=$(tput setaf 9)
        __fg_color10=$(tput setaf 10)
        __fg_color11=$(tput setaf 11)
        __fg_color12=$(tput setaf 12)
        __fg_color13=$(tput setaf 13)
        __fg_color14=$(tput setaf 14)
        __fg_color15=$(tput setaf 15)
    } else {
        __fg_color0=""
        __fg_color1=""
        __fg_color2=""
        __fg_color3=""
        __fg_color4=""
        __fg_color5=""
        __fg_color6=""
        __fg_color7=""
        __fg_color8=""
        __fg_color9=""
        __fg_color10=""
        __fg_color11=""
        __fg_color12=""
        __fg_color13=""
        __fg_color14=""
        __fg_color15=""
    } fi
}

# NOTE: "\[" and "\]" are used below so that bash can calculate the number of
# printed characters. If non-printed characters are not escaped, the shell 
# will lose track of where it is.

function __context(){
    # Set user and host context in the format user@host.

    local __user
    local __host
    local __separator

    __user=$USER
    __host=$HOSTNAME
    __separator="@"

    echo "\[${__fg_color2}${__bold}\]${__user}\[${__reset}\]${__separator}\[${__fg_color3}${__bold}\]${__host}\[${__reset}\]"
}

function __virtualenv_info(){
    # If there is a virtual environment in the current directory, then
    # activate it and show it in the prompt.
    
    if [[ -n "$VIRTUAL_ENV" ]]; then {
        echo " \[${__fg_color5}\](venv:\[${__italic}\]${VIRTUAL_ENV##*/}\[${__reset}\])"
    } fi
}

function __git_info(){
    # If the current directory is inside a git repository, then show the
    # current branch in the prompt.

    if git branch &> /dev/null ; then {
        echo " \[${__fg_color5}\](git:\[${__italic}\]$(git rev-parse --abbrev-ref HEAD)\[${__remove_italic}\])\[${__reset}\]"
    } fi
}

function __exit_status(){
    # If the previous process did not return exit code '0', then show an
    # indicator in the prompt.

    if [[ ! $1 == 0 ]] ; then {
        echo "\[${__fg_color1}${__bold}\]⨉ \[${__reset}\]"
    } fi
}

function __working_dir(){
    # Show the current working directory with '~' replacing the usual
    # '/home/$USER'. If the current working directory has more than four
    # directories in its path, then only show the last three and replace the
    # rest with '.../'. Also sets window title.
        
    local __current_dir
    local __parent_dir
    local __depth
    
    __current_dir=$( echo "$PWD" | sed 's/\/home\/air/~/g' | rev | cut -d'/' -f-1 | rev )
    __parent_dir=$( echo "$PWD" | sed 's/\/home\/air/~/g' | rev | cut -d'/' -f-3 | rev )
    __depth=${PWD//[!\/]} # extract the '/' from pwd
    
    # REFACTOR: This could be one case statement with a check for $TERM at the end.
    # __command='foo' ; if $TERM = 'alacritty' __command+='bar' ; echo $__command

    if [[ $TERM = 'alacritty' ]] || [[ $TERM = 'xterm-kitty' ]] ; then {
        # There are only a few possible cases. In Alacritty and Kitty, print
        # the current directory with potentially truncated parents to the 
        # statusline.
        case ${#__depth} in
            1|2)
                # Show current directory
                if [[ $PWD = "/" ]] ; then {
                    echo " \[${__fg_color12}\]/\[$__status_line/$__finish_status_line${__reset}\]"
                } elif [[ $PWD = "$HOME" ]] ; then {
                    echo " \[${__fg_color12}\]${__current_dir}\[$__status_line${__current_dir}$__finish_status_line${__reset}\]"
                } else {
                    echo " \[${__fg_color12}\]/${__current_dir}\[$__status_line/${__current_dir}$__finish_status_line${__reset}\]"
                } fi
                ;; 
            3)
                # Only show one parent
                __parent_dir=$( echo "$__parent_dir" | cut -d'/' -f-1 )
                echo " \[${__fg_color12}${__dim}\]${__parent_dir}/\[${__remove_dim}\]${__current_dir}\[$__status_line${__parent_dir}/${__current_dir}$__finish_status_line${__reset}\]"
                ;;
            4)
                # Show two parents
                __parent_dir=$( echo "$__parent_dir" | cut -d'/' -f-2 )
                echo " \[${__fg_color12}${__dim}\]${__parent_dir}/\[${__remove_dim}\]${__current_dir}\[$__status_line${__parent_dir}/${__current_dir}$__finish_status_line${__reset}\]"
                ;;
            *)
                # Show two parents and an ellipsis
                __parent_dir=$(echo "$__parent_dir" | cut -d'/' -f-2 )
                echo " \[${__fg_color12}${__dim}\].../${__parent_dir}/\[${__remove_dim}\]${__current_dir}\[$__status_line.../${__parent_dir}/${__current_dir}$__finish_status_line${__reset}\]"
        esac
    } else {
        # In other terminals, don't worry about the statusline.
        case ${#__depth} in
            1|2)
                # Show current directory
                if [[ $PWD = "/" ]] ; then {
                    echo " \[${__fg_color12}\]/\[${__reset}\]"
                } elif [[ $PWD = "$HOME" ]] ; then {
                    echo " \[${__fg_color12}\]${__current_dir}\[${__reset}\]"
                } else {
                    echo " \[${__fg_color12}\]/${__current_dir}\[${__reset}\]"
                } fi
                ;; 
            3)
                # Only show one parent
                __parent_dir=$( echo "$__parent_dir" | cut -d'/' -f-1 )
                echo " \[${__fg_color12}${__dim}\]${__parent_dir}/\[${__remove_dim}\]${__current_dir}\[${__reset}\]"
                ;;
            4)
                # Show two parents
                __parent_dir=$( echo "$__parent_dir" | cut -d'/' -f-2 )
                echo " \[${__fg_color12}${__dim}\]${__parent_dir}/\[${__remove_dim}\]${__current_dir}\[${__reset}\]"
                ;;
            *)
                # Show two parents and an ellipsis
                __parent_dir=$(echo "$__parent_dir" | cut -d'/' -f-2 )
                echo " \[${__fg_color12}${__dim}\].../${__parent_dir}/\[${__remove_dim}\]${__current_dir}\[${__reset}\]"
        esac
    } fi
}

function __prompt_character(){
    # If the current user has root EUID then show '#' as the prompt character,
    # otherwise show '$'.

    if [[ $EUID -ne 0 ]] ; then {
        echo " \[${__fg_color7}${__italic}${__bold}\]\$\[${__reset}\] "
    } else {
        echo " \[${__fg_color7}${__italic}${__bold}\]\#\[${__reset}\] "
    } fi
}

function __interactive_prompt(){
    # Set the prompt for interactive menus. Usually overwritten by the active
    # program.
    
    local __prompt
    __prompt="Please enter a number from the above list:\n"

    echo "\[${__fg_color7}${__italic}\]${__prompt}\[${__reset}\]"
}

function __debug_prompt(){
    # Set the prompt for debugging. Used in debug mode.

    local __character
    __character='+'
    
    echo "\[${__fg_color7}${__bold}${__italic}\]${__character}\[${__reset}\]"
}

function __set_prompts(){
    # This function is called every time the prompt is shown, getting the
    # necessary variables each time the prompt renders.
    
    # Collect previous exit code for exit_status()
    local exit_code=$? # This has to be the first thing in the function
    
    # Initialize style and color variables defined above so that the variables
    # stay local in scope.
    __init_styles
    
    # Not used - displayed after each command, before any output
    PS0=''

    # Normal prompt shown before each command
    PS1="$(__exit_status $exit_code)$(__context)$(__working_dir)$(__git_info)$(__virtualenv_info)$(__prompt_character)"

    # Secondary prompt when a command needs more input
    PS2="$(__exit_status $exit_code)$(__context)$(__prompt_character)"

    # Bash select interactive menus
    PS3="$(__interactive_prompt)"

    # Bash prompt used for tracing a script in debug mode
    PS4="$(__debug_prompt)"
}

PROMPT_COMMAND=__set_prompts


## Aliases

# XDG compliance
alias wget='wget --hsts-file="$XDG_STATE_HOME"/wget-hsts'
alias gpg='gpg2 --homedir "$XDG_DATA_HOME"/gnupg'
alias gdb='gdb -nh -x "$XDG_CONFIG_HOME"/gdb/init'

# Set interactive behavior as default for 'dangerous' shell utilities
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ls
if [[ -x "$(command -v  eza)" ]] ; then { # If eza is installed prefer it
    alias ls='eza --long --no-quotes --sort=extension \
        --group-directories-first --time-style=long-iso \
        --git-ignore --git --git-repos --level=1'
    alias la='eza --long --no-quotes --almost-all --sort=extension \
        --group-directories-first --time-style=long-iso \
        --git --git-repos --level=1'
    alias tree='eza --tree --almost-all --sort=extension \
        --group-directories-first --level=2'
    } else {
    alias ls='ls --color=auto -g --time-style=long-iso --sort=extension \
            --group-directories-first'
    alias la='ls --almost-all --color=auto -g --time-style=long-iso \
            --sort=extension --group-directories-first'
    } fi

# cd
change_dir() {
    # Change default behavior by calling the ls alias after changing
    # directories. If python is installed, manage virtual environment
    # activation automatically.

    local __dir
    local __current_dir
    local __found

    __dir="$*"

    if [[ $# -lt 1 ]] ; then {
        __dir=$HOME
    } fi

    builtin cd "${__dir}" && ls
    
    # Handle Python virtualenvs automatically:
    if [[ -x "$(command -v python)" ]] ; then {
        # If python is installed and a parent directory has a virtual
        # environment, then activate it. Otherwise if a virtual environment
        # is active and a parent directory does not contain a virtual
        # environment, then deactivate the active virtual environment.

        for __env_dir in "venv" ".venv" ; do {
            __current_dir=$(realpath .)
            __found=""
            # Recursively search parent directories for __env_dir:
            while [[ -z "$__found" ]] && [[ -n "$__current_dir" ]] ; do {
                if [[ -e "$__current_dir/$__env_dir" ]] ; then {
                    __found="$__current_dir/$__env_dir"
                } fi
                __current_dir=${__current_dir%/*}
            } done
        } done
        
        # If __env_dir was not found, deactivate. Otherwise activate the found
        # environment.
        if [[ -z "$__found" ]] ; then {
            if [[ -n "${VIRTUAL_ENV+x}" ]] ; then {
                deactivate
            } fi
        } else {
            . "$__found/bin/activate"
        } fi
    } fi
}

alias cd='change_dir'

extract (){
    # Wrapper for various compression/extraction utilities. Extracts the file
    # given as the first argument to the function.

    if [ -f "$1" ] ; then {
        case $1 in
            *.tar.bz2)
                tar xjf "$1"
                ;;
            *.tar.gz)
                tar xzf "$1"
                ;;
            *.bz2)
                bunzip2 "$1"
                ;;
            *.rar)
                unrar x "$1"
                ;;
            *.gz)
                gunzip "$1"
                ;;
            *.tar)
                tar xf "$1"
                ;;
            *.tbz2)
                tar xjf "$1"
                ;;
            *.tgz)
                tar xzf "$1"
                ;;
            *.zip)
                unzip "$1"
                ;;
            *.Z)
                uncompress "$1"
                ;;
            *.7z)
                7z x "$1"
                ;;
            *)
                echo "'$1' cannot be extracted via ex()"
                ;;
        esac
    } else {
        echo "'$1' is not a valid file"
    } fi
}

alias ex=extract

function ipython_wrapper(){
    if [[ -n "${VIRTUAL_ENV+x}" ]] ; then {
        if . "$VIRTUAL_ENV/bin/activate" ; then {
            ipython
            deactivate
        } fi
    } elif [[ -e "$WORKON_HOME/ipython/bin/activate" ]] ; then  {
        if . "$HOME"/.local/share/virtualenvs/ipython/bin/activate ; then {
            ipython
            deactivate
        } fi
    } fi
}

alias ipython=ipython_wrapper

# Julia
if [[ -x "$(command -v julia)" ]] ; then {
    alias julia='julia --banner=no'
} fi

# cat
if [[ -x "$(command -v  bat)" ]] ; then { # If bat is installed prefer it
    alias cat="bat --theme=ansi"
} else {
    alias cat="cat --number-nonblank"
} fi

# ncmpcpp
if [[ -x "$(command -v ncmpcpp)" ]] ; then {
    alias mpc="ncmpcpp --quiet"
} fi

# Minicom
if [[ -x "$(command -v minicom)" ]] ; then {
    alias minicom='minicom --color=on \
        --statlinefmt=" Minicom %V | %b | %T | %D "'
    } fi

# Distribution-specific Aliases
if [[ -f /etc/arch-release ]] ; then {
    # Pacdiff
    if [[ -x "$(command -v pacdiff)" ]] ; then {
        alias pacdiff='DIFFPROG=$EDITOR pacdiff'
    } fi

    if [[ -x "$(command -v paru)" ]] && [[ -x "$(command -v pacdiff)" ]] ; then {
        alias paru='paru && pacdiff'
    } else {
        alias pacman='pacman && pacdiff'
    } fi
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
    alias fastfetch="fastfetch -s Title:OS:Kernel:Shell:Break:Colors:Break \
        --logo arch_small"
} fi

# Welcome Message
fastfetch && cd .
