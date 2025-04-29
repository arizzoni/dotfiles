#!/bin/bash

## Startup
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -r /etc/bash.bashrc ]; then
    source "/etc/bash.bashrc"

fi
source /usr/share/doc/pkgfile/command-not-found.bash

# Set LS_COLORS
if [ -s "$XDG_CONFIG_HOME/dircolors" ] \
    && [ -r "$XDG_CONFIG_HOME/dircolirs" ]; then
    eval "$(dircolors -b "$XDG_CONFIG_HOME/dircolors")"
fi

## Bash options

# Bash Shell Options
shopt -s checkwinsize direxpand dotglob globstar histappend histreedit \
    histverify hostcomplete no_empty_cmd_completion nocaseglob progcomp \
    progcomp_alias promptvars sourcepath
set -o braceexpand noclobber vi
stty -ixon

# Bash Completions
if ! shopt -oq posix; then
    if [[ -r /usr/share/bash-completion/bash_completion ]]; then
        . '/usr/share/bash-completion/bash_completion'
    fi
fi

# Load text styles
if [[ -f "$HOME/.local/bin/style" ]]; then
    source "$HOME/.local/bin/style"
fi

## PSX Prompts
_set_prompts() {
    # This function is called every time the prompt is shown, getting the
    # necessary variables each time the prompt renders.

    # Collect previous exit code for exit_status ()
    # This has to be the first thing in the function
    declare -i _exit_code=$?

    # Prompt component definitions

    _context() {
        # Set user and host context in the format user@host.

        printf '\[%s%s\]%s\[%s\]%s\[%s%s\]%s\[%s\]' \
            "${style["fg_color2"]}" "${style["bold"]}" \
            "\u" "${style["reset"]}" \
            "@" \
            "${style["fg_color3"]}" "${style["bold"]}" \
            "\H " "${style["reset"]}"
    }

    _virtualenv_info() {
        # If there is a virtual environment in the current directory, then
        # activate it and show it in the prompt.

        declare _venv
        _venv=${VIRTUAL_ENV}

        if [[ -n $_venv ]]; then
            printf ' \[%s\](venv:%s)\[%s\]' \
                "${style["fg_color5"]}" "${_venv##*/}" "${style["reset"]}"
        fi
    }

    _git_info() {
        # If the current directory is inside a git repository, then show the
        # current branch and additional git status information.

        if git rev-parse --is-inside-work-tree &> /dev/null; then
            declare _character _status _head _staged_files _unstaged_files \
                _ahead_commits _stash_count _untracked_files _remote

            _character=''
            _status=$(git status --porcelain=v2)
            _head=$(git rev-parse --abbrev-ref HEAD)
            _remote=$(
                git rev-parse \
                    --abbrev-ref --symbolic-full-name "@{u}" 2> /dev/null
            )

            # Check if the branch is tracking a remote branch
            if [[ -z $_remote ]]; then
                _ahead_commits=0 # No remote tracking branch, so no ahead commits
            else
                # Count the number of commits the branch is ahead by, safely
                _ahead_commits=$(
                    git rev-list --count HEAD.."$_remote" 2> /dev/null || echo 0
                )
            fi

            # Check for staged and unstaged changes in a single command
            # A (added), M (modified), D (deleted)
            _staged_files=$(echo "$_status" | grep -c '^A\|^M\|^D')
            # ?? (untracked files)
            _unstaged_files=$(echo "$_status" | grep -c '^??')

            # Count the number of entries in the stash
            _stash_count=$(git stash list | wc -l)

            # Check for untracked files using git ls-files
            _untracked_files=$(git ls-files --others --exclude-standard | wc -l)

            # Check if there are any changes (staged, unstaged, etc.)
            if [[ "$_status" ]]; then
                _character="∆"
            fi

            # Constructing the git prompt display
            printf ' \[%s\](git:%s %s' \
                "${style["fg_color5"]}" "${_head}" "${_character}"

            # Show staged files count
            if [[ $_staged_files -gt 0 ]]; then
                printf " +%d" "$_staged_files"
            fi

            # Show unstaged files count
            if [[ $_unstaged_files -gt 0 ]]; then
                printf " ~%d" "$_unstaged_files"
            fi

            # Show ahead by commits
            if [[ $_ahead_commits -gt 0 ]]; then
                printf " ↑%d" "$_ahead_commits"
            fi

            # Show stash count
            if [[ $_stash_count -gt 0 ]]; then
                printf " ﯶ%d" "$_stash_count"
            fi

            # Show untracked files count
            if [[ $_untracked_files -gt 0 ]]; then
                printf " ?%d" "$_untracked_files"
            fi

            printf ')\[%s\]' "${style["reset"]}"
        fi
    }

    _exit_status() {
        # If the previous process did not return exit code '0', then show an
        # indicator in the prompt.

        if [[ $1 != 0 ]]; then
            declare _character
            _character='⨉ '

            printf "\[%s%s\]%s\[%s\]" \
                "${style["fg_color1"]}" \
                "${style["bold"]}" "${_character}" \
                "${style["reset"]}"
        fi
    }

    _working_dir() {
        printf "\[%s%s\]%s\[%s\]" \
            "${style["fg_color1"]}" \
            "${style["italic"]}" "\w" \
            "${style["reset"]}"
    }

    _prompt_character() {
        # If the current user has root EUID then show '#' as the prompt
        # character otherwise show '$'.

        printf ' \[%s%s%s\]%s\[%s\] ' \
            "${style["fg_color7"]}" "${style["italic"]}" "${style["bold"]}" \
            '$' "${style["reset"]}"
    }

    _interactive_prompt() {
        # Set the prompt for interactive menus. Usually overwritten by the
        # active program.

        declare _prompt
        _prompt="Please enter a number from the above list:\n"
        printf '\[%s%s\]%s\[%s\]' \
            "${style["fg_color7"]}" "${style["italic"]}" \
            "${_prompt}" "${style["reset"]}"
    }

    _debug_prompt() {
        # Set the prompt for debugging. Used in debug mode.

        declare _character
        _character='+'
        printf '\[%s%s%s\]%s\[%s\]' \
            "${style["fg_color7"]}" "${style["bold"]}" "${style["italic"]}" \
            "${_character}" "${style["reset"]}"
    }

    # Displayed after each command, before any output
    PS0=''

    # Normal prompt shown before each command
    PS1=""
    PS1+="$(_exit_status $_exit_code)"
    PS1+="$(_context)"
    PS1+="$(_working_dir)"
    PS1+="$(_git_info)"
    PS1+="$(_virtualenv_info)"
    PS1+="$(_prompt_character)"

    # Secondary prompt when a command needs more input
    PS2=""
    PS2+="$(_exit_status $_exit_code)"
    PS2+="$(_context)"
    PS2+="$(_prompt_character)"

    # Bash select interactive menus
    PS3=""
    PS3+="$(_interactive_prompt)"

    # Bash prompt used for tracing a script in debug mode
    PS4=""
    PS4+="$(_debug_prompt)"

    unset -f \
        _exit_status _context _working_dir _git_info _virtualenv_info \
        _prompt_character _interactive_prompt _debug_prompt
    return
}

PROMPT_COMMAND=(_set_prompts)

## Aliases

# XDG compliance
alias wget='wget --hsts-file="$XDG_STATE_HOME"/wget-hsts'
alias gpg='gpg2 --homedir "$XDG_DATA_HOME"/gnupg'
alias gdb='gdb -nh -x "$XDG_CONFIG_HOME"/gdb/init'

# Fancy colors
alias grep='grep --color=auto'
alias ip='ip --color=auto'

# Open alias
alias open='xdg-open'

# Set interactive behavior as default for 'dangerous' shell utilities
rm() { command rm -i "${@}"; }
cp() { command cp -i "${@}"; }
mv() { command mv -i "${@}"; }

# Let sudo keep the current environment variables
sudo() { command sudo -E "${@}"; }

ls() { # Handle case with only hidden files
    declare _files
    if [[ $# -eq 0 ]]; then
        _files=("$PWD"/*)
        if [[ -e ${_files[0]} || -L ${_files[0]} ]]; then
            command \
                ls -dh --color=auto --time-style=long-iso \
                --sort=extension --group-directories-first \
                ./[!.]*
        fi
    else
        _files=("$@"/[!.]*)
        if [[ -e ${_files[0]} || -L ${_files[0]} ]]; then
            for _directory in "$@"; do
                command \
                    ls -dh --color=auto --time-style=long-iso \
                    --sort=extension --group-directories-first \
                    "${_directory%/}"/[!.]*
            done
        fi
    fi
    return
}

la() { # Handle case with only hidden files
    declare _files
    if [[ $# -eq 0 ]]; then
        _files=("$PWD"/*)
        if [[ -e ${_files[0]} || -L ${_files[0]} ]]; then
            command \
                ls -ldh --color=auto --time-style=long-iso \
                --sort=extension --group-directories-first \
                ./*
        fi
    else
        _files=("$@"/[!.]*)
        if [[ -e ${_files[0]} || -L ${_files[0]} ]]; then
            for _directory in "$@"; do
                command \
                    ls -ldh --color=auto --time-style=long-iso \
                    --sort=extension --group-directories-first \
                    "${_directory%/}"/*
            done
        fi
    fi
    return
}

ll() { # Handle case with only hidden files
    declare _files
    if [[ $# -eq 0 ]]; then
        _files=("$PWD"/*)
        if [[ -e ${_files[0]} || -L ${_files[0]} ]]; then
            command \
                ls -ldh --color=auto --time-style=long-iso \
                --sort=extension --group-directories-first \
                ./[!.]*
        fi
    else
        _files=("$@"/[!.]*)
        if [[ -e ${_files[0]} || -L ${_files[0]} ]]; then
            for _directory in "$@"; do
                command \
                    ls -ldh --color=auto --time-style=long-iso \
                    --sort=extension --group-directories-first \
                    "${_directory%/}"/[!.]*
            done
        fi
    fi
    return
}

# cd
cd() {
    # Change default behavior by calling the ls alias after changing
    # directories. If python is installed, manage virtual environment
    # activation automatically.

    declare _dir _current_dir _found _dir_uid _dir_gid _uid _gid

    _dir="$*"

    if [[ $# -lt 1 ]]; then
        _dir="$HOME"
    fi

    if [[ $_dir != '-' ]]; then
        _dir=$(realpath "$_dir")
    fi

    builtin cd "${_dir}" || return

    _uid=$(id -u)
    _gid=$(id -g)
    _dir_uid=$(stat -c "%u" "$_dir")
    _dir_gid=$(stat -c "%g" "$_dir")

    # If the directory is not owned by the current user or group, then don't
    # blindly export environment variables. A manual export is fine.
    if [[ $_uid -ne $_dir_uid ]] || [[ $_gid -ne $_dir_gid ]]; then
        return
    fi

    # Search current and parent directories for .env or env files, then
    # export the variables contained within. The required format for a
    # .env file is:
    # VARIABLE1=VALUE1
    # VARIABLE2=VALUE2
    for _env_dir in "env" ".env"; do
        _current_dir="$PWD"
        _found=""

        # Recursively search parent directories for _env_dir:
        while [[ -z $_found ]] && [[ -n $_current_dir ]]; do
            if [[ -e "$_current_dir/$_env_dir" ]]; then
                _found="$_current_dir/$_env_dir"
            fi
            _current_dir="${_current_dir%/*}"
        done
    done

    # If _env_dir was not found, if DOTENV is set, then unset all of the
    # environment variables in the DOTENV file.
    # If _env_dir was found, export the environment variables in the file
    # and set DOTENV to the path of the file.
    if [[ -z $_found ]]; then
        if [[ -n ${DOTENV+x} ]]; then
            while read -r _variable; do
                _variable="${_variable%=*}" # everything up the '='
                unset "${_variable?}"
            done < "$DOTENV"
            unset DOTENV
        fi
    else
        while read -r _variable; do
            export "${_variable?}"
        done < "$_found"
        export DOTENV="$_found"
    fi

    # Handle Python virtualenvs automatically:
    if [[ -x "$(command -v python)" ]]; then
        # If python is installed and a parent directory has a virtual
        # environment, then activate it. Otherwise if a virtual environment
        # is active and a parent directory does not contain a virtual
        # environment, then deactivate the active virtual environment.

        for _env_dir in "venv" ".venv"; do
            _current_dir="$PWD"
            _found=""

            # Recursively search parent directories for _env_dir:
            while [[ -z $_found ]] && [[ -n $_current_dir ]]; do
                if [[ -e "$_current_dir/$_env_dir" ]]; then
                    _found="$_current_dir/$_env_dir"
                fi
                _current_dir="${_current_dir%/*}"
            done
        done

        # If _env_dir was not found, deactivate. Otherwise activate the found
        # environment.
        if [[ -z $_found ]]; then
            if [[ -n ${VIRTUAL_ENV+x} ]]; then
                deactivate
            fi
        else
            # shellcheck source=/dev/null
            . "$_found/bin/activate"
        fi
    fi
    unset _dir _current_dir _found _dir_uid _dir_gid _uid _gid
    return
}

# run-help() { help "$READLINE_LINE" 2>/dev/null || man "$READLINE_LINE"; }
# bind -m vi-insert -x '"\eh": run-help'
# bind -m emacs -x     '"\eh": run-help'

# TODO get this working with fzy
#   # CTRL-T - Paste the selected file path into the command line
#   if [[ "${FZF_CTRL_T_COMMAND-x}" != "" ]]; then
#     bind -m emacs-standard '"\C-t": " \C-b\C-k \C-u`__fzf_select__`\e\C-e\er\C-a\C-y\C-h\C-e\e \C-y\ey\C-x\C-x\C-f"'
#     bind -m vi-command '"\C-t": "\C-z\C-t\C-z"'
#     bind -m vi-insert '"\C-t": "\C-z\C-t\C-z"'
#   fi
#
#   # CTRL-R - Paste the selected command from history into the command line
#   bind -m emacs-standard '"\C-r": "\C-e \C-u\C-y\ey\C-u`__fzf_history__`\e\C-e\er"'
#   bind -m vi-command '"\C-r": "\C-z\C-r\C-z"'
#   bind -m vi-insert '"\C-r": "\C-z\C-r\C-z"'
# else
#   # CTRL-T - Paste the selected file path into the command line
#   if [[ "${FZF_CTRL_T_COMMAND-x}" != "" ]]; then
#     bind -m emacs-standard -x '"\C-t": fzf-file-widget'
#     bind -m vi-command -x '"\C-t": fzf-file-widget'
#     bind -m vi-insert -x '"\C-t": fzf-file-widget'
#   fi
#
#   # CTRL-R - Paste the selected command from history into the command line
#   bind -m emacs-standard -x '"\C-r": __fzf_history__'
#   bind -m vi-command -x '"\C-r": __fzf_history__'
#   bind -m vi-insert -x '"\C-r": __fzf_history__'
# fi
#
# # ALT-C - cd into the selected directory
# if [[ "${FZF_ALT_C_COMMAND-x}" != "" ]]; then
#   bind -m emacs-standard '"\ec": " \C-b\C-k \C-u`__fzf_cd__`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
#   bind -m vi-command '"\ec": "\C-z\ec\C-z"'
#   bind -m vi-insert '"\ec": "\C-z\ec\C-z"'
# fi

# Neovim
if [[ -x "$(command -v nvim)" ]]; then
    if [[ -x "$(command -v neovide)" ]]; then
        nvim() {
            neovide -- "$@"
        }
    fi
fi

# TODO: Smart Diff
# context sensitive file diff
# if in git repo use git diff
# else use neovim directly
alias diff='diff -syt --color="auto"'

# Python
if [[ -x "$(command -v python)" ]]; then
    # IPython
    ipython() {
        if [[ -n ${VIRTUAL_ENV+x} ]]; then
            # shellcheck source=/dev/null
            if . "$VIRTUAL_ENV/bin/activate"; then
                "$VIRTUAL_ENV/bin/ipython"
                deactivate
            fi
        elif [[ -e "$WORKON_HOME/ipython/bin/activate" ]]; then
            # shellcheck source=/dev/null
            if . "$WORKON_HOME/ipython/bin/activate"; then
                "$WORKON_HOME/ipython/bin/ipython"
                deactivate
            fi
        fi
    }
fi

# MATLAB
if [[ -x "$(command -v matlab)" ]] && [[ -r "/etc/arch-release" ]]; then
    matlab() { command matlab -nodesktop -nosplash; }
    matlab-run() { command matlab -nodesktop -nosplash -r "$1"; }
fi

# Distribution-specific Aliases
if [[ -r /etc/arch-release ]]; then
    if [[ -x "$(command -v pacdiff)" ]]; then
        alias pacdiff="DIFFPROG=\"\$EDITOR -d\" pacdiff"
        alias pactree='pactree -c'
    fi
elif [[ -r /etc/debian-release ]]; then
    # TODO
    return
fi

alias chwal='chwal -d ~/pictures/wallpapers/space -p ~/.local/bin/pre_hook -P ~/.local/bin/post_hook'

fetch && cd .
