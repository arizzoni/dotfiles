#!/bin/env bash

## Startup
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -r /etc/bash.bashrc ]; then {
        # shellcheck source=/dev/null
    . /etc/bash.bashrc
} fi

## Bash options

# Bash Shell Options
shopt -s checkwinsize direxpand dotglob globstar histappend histreedit \
    histverify hostcomplete no_empty_cmd_completion nocaseglob progcomp \
    progcomp_alias promptvars sourcepath
set -o braceexpand noclobber vi
stty -ixon

# Bash Completions
if ! shopt -oq posix ; then {
    if [[ -r /usr/share/bash-completion/bash_completion ]]; then {
        # shellcheck source=/dev/null
        . '/usr/share/bash-completion/bash_completion'
    } elif [[ -r /etc/bash_completion ]] ; then {
        # shellcheck source=/dev/null
        . '/etc/bash_completion'
    } fi
} fi


## PSX Prompts
__set_prompts () {
    # This function is called every time the prompt is shown, getting the
    # necessary variables each time the prompt renders.

    # Collect previous exit code for exit_status ()
    local __exit_code=$? # This has to be the first thing in the function
    
    # Define text styles
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

    __context () {
        # Set user and host context in the format user@host.

        local __user __host __separator_character

        __user=$(id -un)
        __host=$(uname -n)
        __separator_character="@"

        printf '\[%s%s\]%s\[%s\]%s\[%s%s\]%s\[%s\]' \
            "${__fg_color2}" "${__bold}" "${__user}" "${__reset}" \
            "${__separator_character}" \
            "${__fg_color3}" "${__bold}" "${__host}" "${__reset}"
    }

    __virtualenv_info () {
        # If there is a virtual environment in the current directory, then
        # activate it and show it in the prompt.
        
        local __venv
        __venv=${VIRTUAL_ENV}
        
        if [[ -n "$__venv" ]]; then {
            printf ' \[%s\](venv:%s)\[%s\]' \
            "${__fg_color5}" "${__venv##*/}" "${__reset}"
        } fi
    }

    __git_info () {
        # If the current directory is inside a git repository, then show the
        # current branch in the prompt.

        # TODO: number of files changed, number of entries in stash, ahead by
        # x commits, number of files changed but not staged, untracked files 

        if git branch &> /dev/null ; then {
            local __character __status __head
            __character=''
            __status=$(git status --porcelain)
            __head=$(git rev-parse --abbrev-ref HEAD)

            if [[ "$__status" ]] ; then {
                __character=" ~"
            } fi

            printf ' \[%s\](git:%s)%s\[%s\]' \
                "${__fg_color5}" "${__head}" "${__character}" "${__reset}"
        } fi
    }

    __exit_status () {
        # If the previous process did not return exit code '0', then show an
        # indicator in the prompt.

        if [[ ! $1 == 0 ]] ; then {
            local __character
            __character='⨉ '

            printf "\[%s%s\]%s\[%s\]" \
                "${__fg_color1}" "${__bold}" "${__character}" "${__reset}"
        } fi
    }

    __working_dir () {
        # Show the current working directory with '~' replacing the usual
        # '/home/$USER'. If the current working directory has more than four
        # directories in its path, then only show the last three and replace
        # the rest with '.../'. Also sets statusline.

        local __home_character __user __pwd __home

        __uid=$(id -u)
        __pwd=$(pwd)
        __user_data=$(getent passwd "$__uid")
        __home="${__user_data#*::}"
        __home="${__home%:*}"
        __user="${__home##*/}"

        if [[ $__uid = 0 ]] ; then {
            __home_character=''
        } else {
            __home_character='~'
        } fi
        
        if [[ "$__pwd" == "$__home" ]] ; then {
            # If the terminal supports the statusline, then use it
            if [[ -n "$__to_status_line" ]] ; then {
                printf ' \[%s\]%s\[%s%s%s%s\]' \
                    "${__fg_color12}" "${__home_character}" \
                    "${__to_status_line}" "${__home_character}" \
                    "${__from_status_line}" "${__reset}"
            } else {
                printf ' \[%s\]%s\[%s\]' \
                    "${__fg_color12}" "${__home_character}" "${__reset}"
            } fi
        } else {
            local __current_dir __parent_dir __depth
            
        if [[ $__uid = 0 ]] ; then {
            __current_dir="${__pwd}"
        } else {
            # Replace '/home/$__user' with '$__home_character'
            __current_dir="${__pwd//\/home\/$__user/$__home_character}"
        } fi

            # extract the '/' from pwd
            __depth=${__current_dir//[!\/]}

            # Strip trailing '/'
            __current_dir="${__current_dir%/}"

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

            # Strip everything after the last '/'
            __parent_dir="${__current_dir%/*}"
            
            # Strip everything before the last '/'
            __current_dir="${__current_dir##*/}"

            if [[ -n "$__to_status_line" ]] ; then {
                printf ' \[%s%s\]%s/\[%s\]%s\[%s/%s%s%s\]' \
                    "${__fg_color12}" "${__dim}" "${__parent_dir}" \
                    "${__remove_dim}" "${__current_dir}" \
                    "${__to_status_line}" "${__current_dir}" \
                    "${__from_status_line}" "${__reset}\]"
            } else {
                printf ' \[%s%s\]%s/\[%s\]%s\[%s\]' \
                "${__fg_color12}" "${__dim}" "${__parent_dir}" \
                "${__remove_dim}" "${__current_dir}" "${__reset}"
            } fi
        } fi
    }

    __prompt_character () {
        # If the current user has root EUID then show '#' as the prompt
        # character otherwise show '$'.

        local __character __uid

        __character='\$'
        __uid=$(id -u)

        if [[ "$__uid" -eq 0 ]] ; then {
            __character='\$'
        } fi

        printf ' \[%s%s%s\]%s\[%s\] ' \
            "${__fg_color7}" "${__italic}" "${__bold}" \
            "${__character}" "${__reset}"
    }

    __interactive_prompt () {
        # Set the prompt for interactive menus. Usually overwritten by the
        # active program.
        
        local __prompt
        __prompt="Please enter a number from the above list:\n"
        printf '\[%s%s\]%s\[%s\]' \
            "${__fg_color7}" "${__italic}" "${__prompt}" "${__reset}"
    }

    __debug_prompt () {
        # Set the prompt for debugging. Used in debug mode.

        local __character
        __character='+'
        printf '\[%s%s%s\]%s\[%s\]' \
            "${__fg_color7}" "${__bold}" "${__italic}" \
            "${__character}" "${__reset}"
    }

    # Not used - displayed after each command, before any output
    PS0=''

    # Normal prompt shown before each command
    PS1="$(__exit_status $__exit_code)$(__context)$(__working_dir)"
    PS1="${PS1}$(__git_info)$(__virtualenv_info)$(__prompt_character)"

    # Secondary prompt when a command needs more input
    PS2="$(__exit_status $__exit_code)$(__context)$(__prompt_character)"

    # Bash select interactive menus
    PS3="$(__interactive_prompt)"

    # Bash prompt used for tracing a script in debug mode
    PS4="$(__debug_prompt)"

    unset \
        __exit_status __context __working_dir __git_info __virtualenv_info \
        __prompt_character __interactive_prompt __debug_prompt
}

PROMPT_COMMAND=( __set_prompts )


## Aliases

# XDG compliance
alias wget='wget --hsts-file="$XDG_STATE_HOME"/wget-hsts'
alias gpg='gpg2 --homedir "$XDG_DATA_HOME"/gnupg'
alias gdb='gdb -nh -x "$XDG_CONFIG_HOME"/gdb/init'

# Set interactive behavior as default for 'dangerous' shell utilities
rm () { command rm -i "${@}"; }
cp () { command cp -i "${@}"; }
mv () { command mv -i "${@}"; }

# Let sudo keep the current environment variables
sudo () { command sudo -E "${@}"; }

# ls
ls () {
    local __files
    if [[ $# -eq 0 ]] ; then {
        __files=( "$PWD"/* )
        if [[ -e ${__files[0]} || -L ${__files[0]} ]] ; then {
            command \
                ls -dh --color=auto --time-style=long-iso \
                --sort=extension --group-directories-first \
                ./[!.]*
        } fi
    } else {
        __files=( "$@"/[!.]* )
        if [[ -e ${__files[0]} || -L ${__files[0]} ]] ; then {
            for __directory in "$@" ; do {
                command \
                    ls -dh --color=auto --time-style=long-iso \
                    --sort=extension --group-directories-first \
                    "${__directory%/}"/[!.]*
            } done
        } fi
    } fi
}

ll () {
    local __files
    if [[ $# -eq 0 ]] ; then {
        __files=( "$PWD"/* )
        if [[ -e ${__files[0]} || -L ${__files[0]} ]] ; then {
            command \
                ls -ldh --color=auto --time-style=long-iso \
                --sort=extension --group-directories-first \
                ./[!.]*
        } fi
    } else {
        __files=( "$@"/[!.]* )
        if [[ -e ${__files[0]} || -L ${__files[0]} ]] ; then {
            for __directory in "$@" ; do {
                command \
                    ls -ldh --color=auto --time-style=long-iso \
                    --sort=extension --group-directories-first \
                    "${__directory%/}"/[!.]*
            } done
        } fi
    } fi
}

la () {
    local __files
    if [[ $# -eq 0 ]] ; then {
        __files=( "$PWD"/* )
        if [[ -e ${__files[0]} || -L ${__files[0]} ]] ; then {
            command \
                ls -ldh --color=auto --time-style=long-iso \
                --sort=extension --group-directories-first \
                ./*
        } fi
    } else {
        __files=( "$@"/* )
        if [[ -e ${__files[0]} || -L ${__files[0]} ]] ; then {
            for __directory in "$@" ; do {
                command \
                    ls -ldh --color=auto --time-style=long-iso \
                    --sort=extension --group-directories-first \
                    "${__directory%/}"/*
            } done
        } fi
    } fi
}

# cd
cd () {
    # Change default behavior by calling the ls alias after changing
    # directories. If python is installed, manage virtual environment
    # activation automatically.

    local __dir __current_dir __found __dir_uid __dir_gid __uid __gid

    __dir="$*"

    if [[ $# -lt 1 ]] ; then {
        __dir="$HOME"
    } fi

    __dir=$(realpath "$__dir")

    builtin cd "${__dir}" || return 1

    __uid=$(id -u)
    __gid=$(id -g)
    __dir_uid=$(stat -c "%u" "$__dir")
    __dir_gid=$(stat -c "%g" "$__dir")

    # If the directory is not owned by the current user or group, then don't
    # blindly export environment variables. A manual export is fine.
    if [[ "$__uid" -ne "$__dir_uid" ]] || \
        [[ "$__gid" -ne "$__dir_gid" ]] ; then {
        return 1
    } fi

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
    unset __dir __current_dir __found __dir_uid __dir_gid __uid __gid
}

# fzy () { # TODO
#     # Wrapper for fzy to emulate fzf behavior
#     if [[ -x "$(command -v fzy)" ]] ; then {
#         if [[ -x "$(command -v fd)" ]] ; then {
#             alias fzf='fd . | fzy'
#         } else {
#         alias fzf='find . | fzy'
#         } fi
#     } fi
# }

if [[ -x "$(command -v fzy)" ]] ; then {
    if [[ -x "$(command -v fd)" ]] ; then {
        alias fzf='fd . | fzy'
    } else {
    alias fzf='find . | fzy'
    } fi
} fi

extract () {
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
                printf '%s cannot be extracted via extract ()' "$1"
                ;;
        esac
    } else {
                printf '%s is not a valid file' "$1"
    } fi
}

loc () {
    # Prints the number of lines in files with the provided suffixes.
    # Usage: loc 'suffix1' 'suffix2' ... 'suffixN'
    #        e.g. loc 'lua', loc 'py' 'toml', loc 'c' 'h'
    
    local __lines __extension

    for __extension in "$@"; do {
        __lines=$( \
            find ./* -name "*.$__extension" -print0 \
            | xargs -0 wc -l \
            | grep total \
        )
        __lines="${__lines//[!0-9]/}"

        if [[ -z $__lines ]] ; then {
            __lines=0
        } fi

        printf '%s\n' "$__lines"
    } done
}

# Neovim
if [[ -x "$(command -v nvim)" ]] ; then {
    alias nvim='nvim'
    alias diff='nvim -d'
} fi

# Python
if [[ -x "$(command -v python)" ]] ; then {
    # IPython
    ipython () {
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

    # Python UV
    if [[ -x "$(command -v uv)" ]] ; then {
        alias pip='uv pip'
    } fi
} fi

# MATLAB
if [[ -x "$(command -v matlab)" ]] ; then {
    matlab () {
        LD_PRELOAD=/usr/lib/libstdc++.so.6.0.33 command matlab
    }

    matlab-run () {
        matlab -nodesktop -nosplash -r "$1"
    }
} fi

# Distribution-specific Aliases
if [[ -r /etc/arch-release ]] ; then {
    __mirror-update () {
        # If the mirrorlist hasn't been updated in more than a week, update it
        # and select the 10 fastest mirrors that support https. Requires the
        # rankmirrors program from the pacman-contrib package.

        local __mirrorlist_epoch __current_epoch __delta_epoch

        __mirrorlist_epoch=$(date -r /etc/pacman.d/mirrorlist +%s)
        __current_epoch=$(date +%s)
        __delta_epoch=$(( __current_epoch - __mirrorlist_epoch ))

        # Use printf to set the variable so the url string can be split up
       printf -v __mirrorlist_url '%s' \
            'https://archlinux.org/mirrorlist/' \
            '?country=CA&country=US&protocol=https&use_mirror_status=on'

        if [[ $__delta_epoch -gt 604800 ]] ; then {
            printf 'Updating mirrorlist.\n'
            sudo sh -c \
                cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup \
                && curl -s "$__mirrorlist_url" \
                | sed -e 's/^#Server/Server/' -e '/^#/d' \
                | rankmirrors -n 5 - \
                >| /etc/pacman.d/mirrorlist
        } fi

        unset __mirrorlist_epoch __current_epoch __delta_epoch
    }

    if [[ -x "$(command -v pacdiff)" ]] ; then {
        if [[ -x "$(command -v paru)" ]] ; then {
            paru () {
                __mirror-update \
                    && command paru "$@" \
                    && sudo DIFFPROG="$EDITOR -d" pacdiff \
                    && command paccache -r -q
                }
        } else {
            pacman () {
                __mirror-update \
                    && command pacman "$@" \
                    && sudo DIFFPROG="$EDITOR -d" pacdiff \
                    && command paccache -r -q
                }
        } fi
    } fi
} fi

# Minicom
if [[ -x "$(command -v minicom)" ]] ; then {
    alias minicom='minicom --color=on \
        --statlinefmt=" Minicom %V | %b | %T | %D "'
} fi


## Welcome Message
fastfetch -s Title:OS:Kernel:Shell:Break:Colors:Break --logo arch_small \
    && cd . && ll .
