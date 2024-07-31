#!/usr/bin/env bash

## Startup
# If not running interactively, don't do anything
[[ $- != *i* ]] && return


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
        # shellcheck source=/dev/null
        . '/etc/bash_completion'
    } fi
} fi


## PSX Prompts
function __set_prompts () {
    # This function is called every time the prompt is shown, getting the
    # necessary variables each time the prompt renders.

    # Collect previous exit code for exit_status()
    local __exit_code=$? # This has to be the first thing in the function
    
    # Define test styles
    if [[ $(tput bold) ]] ; then {
        local __bold __remove_bold
        __bold="$(tput bold)"
        __remove_bold="\e[2m"
    } else {
        __bold=""
        __remove_bold=""
    } fi
    
    if [[ $(tput sgr0) ]] ; then {
        local __reset
        __reset="$(tput sgr0)"
    } else {
        __reset=""
    } fi

    if [[ $(tput sitm) ]] ; then {
        local __italic
        __italic="$(tput sitm)"
    } else {
        __italic=""
    } fi

    if [[ $(tput ritm) ]] ; then {
        local __remove_italic
        __remove_italic="$(tput ritm)"
    } else {
        __remove_italic=""
    } fi

    if [[ $(tput dim) ]] ; then {
        local __dim __remove_dim
        __dim="$(tput dim)"
        __remove_dim="\e[22m"
    } else {
        __dim=""
        __remove_dim=""
    } fi

    if [[ $(tput tsl) ]] ; then {
        local __to_status_line
        __to_status_line="$(tput tsl)"
    } else {
        __to_status_line=""
    } fi

    if [[ $(tput fsl) ]] ; then {
        local __from_status_line
        __from_status_line="$(tput fsl)"
    } else {
        __from_status_line=""
    } fi

    # Define text colors
    if [[ $(tput setaf 0) ]] ; then {
        __fg_color0="$(tput setaf 0)"
        __fg_color1="$(tput setaf 1)"
        __fg_color2="$(tput setaf 2)"
        __fg_color3="$(tput setaf 3)"
        __fg_color4="$(tput setaf 4)"
        __fg_color5="$(tput setaf 5)"
        __fg_color6="$(tput setaf 6)"
        __fg_color7="$(tput setaf 7)"
        __fg_color8="$(tput setaf 8)"
        __fg_color9="$(tput setaf 9)"
        __fg_color10="$(tput setaf 10)"
        __fg_color11="$(tput setaf 11)"
        __fg_color12="$(tput setaf 12)"
        __fg_color13="$(tput setaf 13)"
        __fg_color14="$(tput setaf 14)"
        __fg_color15="$(tput setaf 15)"
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

    # Prompt component definitions

    # NOTE: "\[" and "\]" are used below so that bash can calculate the number of
    # printed characters. If non-printed characters are not escaped, the shell 
    # will lose track of where the prompt is.

    function __context () {
        # Set user and host context in the format user@host.

        local __user __host __separator_character

        __user=$USER
        __host=$HOSTNAME
        __separator_character="@"

        echo "\[${__fg_color2}${__bold}\]${__user}\[${__reset}\]${__separator_character}\[${__fg_color3}${__bold}\]${__host}\[${__reset}\]"
    }

    function __virtualenv_info () {
        # If there is a virtual environment in the current directory, then
        # activate it and show it in the prompt.
        
        if [[ -n ${VIRTUAL_ENV+x} ]]; then {
            echo " \[${__fg_color5}\](venv:${VIRTUAL_ENV##*/})\[${__reset}\]"
        } fi
    }

    function __git_info () {
        # If the current directory is inside a git repository, then show the
        # current branch in the prompt.

        # TODO: number of files changed, number of entries in stash, ahead by x
        # commits, number of files changed but not staged, untracked files, 

        if git branch &> /dev/null ; then {
            local __character
            __character=''

            if [[ "$(git status --porcelain)" ]] ; then {
                __character="$__character ~"
            } fi

            echo " \[${__fg_color5}\](git:$(git rev-parse --abbrev-ref HEAD)${__character})\[${__reset}\]"
        } fi
    }

    function __exit_status () {
        # If the previous process did not return exit code '0', then show an
        # indicator in the prompt.

        if [[ ! $1 == 0 ]] ; then {
            local __character
            __character='⨉ '

            echo "\[${__fg_color1}${__bold}\]${__character}\[${__reset}\]"
        } fi
    }

    function __working_dir () {
        # Show the current working directory with '~' replacing the usual
        # '/home/$USER'. If the current working directory has more than four
        # directories in its path, then only show the last three and replace the
        # rest with '.../'. Also sets statusline.

        local __home_character

        __home_character='~'
        
        if [[ "$PWD" = "$HOME" ]] ; then {
            # If the terminal supports the statusline, then use it
            if [[ -n "$__to_status_line" ]] ; then {
                echo " \[${__fg_color12}\]${__home_character}\[${__to_status_line}${__home_character}${__from_status_line}${__reset}\]"
            } else {
                echo " \[${__fg_color12}\]${__home_character}\[${__reset}\]"
            } fi
        } else {
            local __current_dir __parent_dir __depth

            __current_dir="${PWD//\/home\/air/$__home_character}" # Replace '/home/air' with '~'
            __depth=${__current_dir//[!\/]} # extract the '/' from pwd
            __current_dir="${__current_dir%/}" # Strip trailing '/'

            # Remove path elements, from the left, until it is the right size
            while (( ${#__depth} > 2 )) ; do
                __current_dir="${__current_dir#*/}"
                # Only take the '/' so we can count them to find the depth
                __depth=${__current_dir//[!\/]}
                # If we had to do the while loop, then on the last iteration
                # add '.../' to the beginning of the string. The two numbers
                # here must be the same - '2' seems to be the most pleasant.
                if (( ${#__depth} == 2 )) ; then {
                    __current_dir=".../${__current_dir}"
                } fi
            done

            __parent_dir="${__current_dir%/*}" # Strip everything after the last '/'
            __current_dir="${__current_dir##*/}" # Strip everything before the last '/'

            if [[ -n "$__to_status_line" ]] ; then {
                echo " \[${__fg_color12}${__dim}\]${__parent_dir}/\[${__remove_dim}\]${__current_dir}\[${__to_status_line}/${__current_dir}${__from_status_line}${__reset}\]"
            } else {
                echo " \[${__fg_color12}${__dim}\]${__parent_dir}/\[${__remove_dim}\]${__current_dir}\[${__reset}\]"
            } fi
        } fi
    }

    function __prompt_character () {
        # If the current user has root EUID then show '#' as the prompt character,
        # otherwise show '$'.

        if [[ $EUID -ne 0 ]] ; then {
            echo " \[${__fg_color7}${__italic}${__bold}\]\$\[${__reset}\] "
        } else {
            echo " \[${__fg_color7}${__italic}${__bold}\]\#\[${__reset}\] "
        } fi
    }

    function __interactive_prompt () {
        # Set the prompt for interactive menus. Usually overwritten by the active
        # program.
        
        local __prompt
        __prompt="Please enter a number from the above list:\n"
        echo "\[${__fg_color7}${__italic}\]${__prompt}\[${__reset}\]"
    }

    function __debug_prompt () {
        # Set the prompt for debugging. Used in debug mode.

        local __character
        __character='+'
        echo "\[${__fg_color7}${__bold}${__italic}\]${__character}\[${__reset}\]"
    }

    # Not used - displayed after each command, before any output
    PS0=''

    # Normal prompt shown before each command
    PS1="$(__exit_status $__exit_code)$(__context)$(__working_dir)$(__git_info)$(__virtualenv_info)$(__prompt_character)"

    # Secondary prompt when a command needs more input
    PS2="$(__exit_status $__exit_code)$(__context)$(__prompt_character)"

    # Bash select interactive menus
    PS3="$(__interactive_prompt)"

    # Bash prompt used for tracing a script in debug mode
    PS4="$(__debug_prompt)"

    unset __exit_status __context __working_dir __git_info __virtualenv_info __prompt_character __interactive_prompt __debug_prompt
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

# Let sudo keep the current environment
alias sudo='sudo -E'

# ls
function ls () {
    local __files
    if [[ $# -eq 0 ]] ; then {
        __files=( "$PWD"/* )
        if [[ -e ${__files[0]} || -L ${__files[0]} ]] ; then {
            command ls -dh --color=auto --time-style=long-iso --sort=extension --group-directories-first ./[!.]*
        } fi
    } else {
        __files=( "$@"/[!.]* )
        if [[ -e ${__files[0]} || -L ${__files[0]} ]] ; then {
            for __directory in "$@" ; do {
                command ls -dh --color=auto --time-style=long-iso --sort=extension --group-directories-first "${__directory%/}"/[!.]*
            } done
        } fi
    } fi
}

function ll () {
    local __files
    if [[ $# -eq 0 ]] ; then {
        __files=( "$PWD"/* )
        if [[ -e ${__files[0]} || -L ${__files[0]} ]] ; then {
            command ls -ldh --color=auto --time-style=long-iso --sort=extension --group-directories-first ./[!.]*
        } fi
    } else {
        __files=( "$@"/[!.]* )
        if [[ -e ${__files[0]} || -L ${__files[0]} ]] ; then {
            for __directory in "$@" ; do {
                command ls -ldh --color=auto --time-style=long-iso --sort=extension --group-directories-first "${__directory%/}"/[!.]*
            } done
        } fi
    } fi
}

function la () {
    local __files
    if [[ $# -eq 0 ]] ; then {
        __files=( "$PWD"/* )
        if [[ -e ${__files[0]} || -L ${__files[0]} ]] ; then {
            command ls -ldh --color=auto --time-style=long-iso --sort=extension --group-directories-first ./*
        } fi
    } else {
        __files=( "$@"/* )
        if [[ -e ${__files[0]} || -L ${__files[0]} ]] ; then {
            for __directory in "$@" ; do {
                command ls -ldh --color=auto --time-style=long-iso --sort=extension --group-directories-first "${__directory%/}"/*
            } done
        } fi
    } fi
}

# cd
function cd () {
    # Change default behavior by calling the ls alias after changing
    # directories. If python is installed, manage virtual environment
    # activation automatically.

    local __dir __current_dir __found

    __dir="$*"

    if [[ $# -lt 1 ]] ; then {
        __dir="$HOME"
    } fi

    builtin cd "${__dir}" || return 1

    # Search current and parent directories for .env or env files, then
    # export the variables contained within. The required format for a
    # .env file is:
    # VARIABLE1=VALUE1
    # VARIABLE2=VALUE2
    for __env_dir in "env" ".env" ; do {
    __current_dir="$PWD"
    __found=""

        # Recursively search parent directories for __env_dir:
        while [[ -z "$__found" ]] && [[ -n "$__current_dir" ]] ; do {
            if [[ -e "$__current_dir/$__env_dir" ]] ; then {
                __found="$__current_dir/$__env_dir"
            } fi
            __current_dir="${__current_dir%/*}"
        } done
    } done

    # If __env_dir was not found, if DOTENV is set, then unset all of the
    # environment variables in the DOTENV file.
    # If __env_dir was found, export the environment variables in the file
    # and set DOTENV to the path of the file.
    if [[ -z "$__found" ]] ; then {
        if [[ -n "${DOTENV+x}" ]] ; then {
            while read -r __variable ; do
                __variable="${__variable%=*}" # everything up the '='
                unset "${__variable?}"
            done <"$DOTENV"
            unset DOTENV
        } fi
    } else {
        while read -r __variable ; do
            export "${__variable?}"
        done <"$__found"
        export DOTENV="$__found"
    } fi
    
    # Handle Python virtualenvs automatically:
    if [[ -x "$(command -v python)" ]] ; then {
        # If python is installed and a parent directory has a virtual
        # environment, then activate it. Otherwise if a virtual environment
        # is active and a parent directory does not contain a virtual
        # environment, then deactivate the active virtual environment.

        for __env_dir in "venv" ".venv" ; do {
            __current_dir="$PWD"
            __found=""

            # Recursively search parent directories for __env_dir:
            while [[ -z "$__found" ]] && [[ -n "$__current_dir" ]] ; do {
                if [[ -e "$__current_dir/$__env_dir" ]] ; then {
                    __found="$__current_dir/$__env_dir"
                } fi
                __current_dir="${__current_dir%/*}"
            } done
        } done
        
        # If __env_dir was not found, deactivate. Otherwise activate the found
        # environment.
        if [[ -z "$__found" ]] ; then {
            if [[ -n "${VIRTUAL_ENV+x}" ]] ; then {
                deactivate
            } fi
        } else {
            # shellcheck source=/dev/null
            . "$__found/bin/activate"
        } fi
    } fi
}

function extract () {
    # Wrapper for various compression/extraction utilities. Extracts the file
    # given as the first argument to the function.

    if [[ -f "$1" ]] ; then {
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

function ipython () {
    if [[ -n "${VIRTUAL_ENV+x}" ]] ; then {
        # shellcheck source=/dev/null
        if . "$VIRTUAL_ENV/bin/activate" ; then {
            "$VIRTUAL_ENV/bin/ipython"
            deactivate
        } fi
    } elif [[ -e "$WORKON_HOME/ipython/bin/activate" ]] ; then  {
        # shellcheck source=/dev/null
        if . "$WORKON_HOME/ipython/bin/activate" ; then {
            "$WORKON_HOME/ipython/bin/ipython"
            deactivate
        } fi
    } fi
}

# Julia
if [[ -x "$(command -v julia)" ]] ; then {
    alias julia='julia --banner=no'
} fi

# MATLAB
if [[ -x "$(command -v matlab)" ]] ; then {
    alias matlab='matlab -nodesktop -nosplash'
} fi

# cat
if [[ -x "$(command -v bat)" ]] ; then { # If bat is installed prefer it
    alias bat="bat --theme=ansi"
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
    # If the mirrorlist hasn't been updated in more than a week, update it and
    # select the 10 fastest mirrors in America and Canada that support https.
    # Requires rankmirrors from pacman-contrib package.
    function mirror-update () {
        local __mirrorlist_epoch __current_epoch __delta_epoch
        __mirrorlist_epoch=$(date -r /etc/pacman.d/mirrorlist +%s)
        __current_epoch=$(date +%s)
        __delta_epoch=$(( __current_epoch - __mirrorlist_epoch ))
        if [[ $__delta_epoch -gt 604800 ]] ; then {
            echo 'Updating mirrorlist.'
            sudo sh -c \
                "cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup \
                && curl -s 'https://archlinux.org/mirrorlist/?country=US&country=CA&protocol=https&use_mirror_status=on' \
                | sed -e 's/^#Server/Server/' -e '/^#/d' \
                | rankmirrors -n 10 - \
                >| /etc/pacman.d/mirrorlist"
        } fi
        unset __mirrorlist_epoch __current_epoch __delta_epoch
    }

    if [[ -x "$(command -v pacdiff)" ]] ; then {
        if [[ -x "$(command -v paru)" ]] ; then {
            function paru () {
                mirror-update \
                    && command paru "$@" \
                    && sudo DIFFPROG="$EDITOR -d" pacdiff \
                    && command paccache -r
                }
        } else {
            function pacman () {
                mirror-update \
                    && sudo command pacman "$@" \
                    && sudo DIFFPROG="$EDITOR -d" pacdiff \
                    && command paccache -r
                }
        } fi
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

if [[ -x "$(command -v kmon)" ]] ; then {
    alias kmon='sudo kmon --color=white --accent-color=blue'
} fi

# Fastfetch
if [[ -x "$(command -v fastfetch)" ]] ; then {
    alias fastfetch="fastfetch -s Title:OS:Kernel:Shell:Break:Colors:Break \
        --logo arch_small"
} fi

alias school='cd ~/documents/academic/graduate/2024-autumn/'


## Welcome Message
fastfetch && cd . && ll .
