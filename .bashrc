#p!/usr/bin/env bash

## Startup

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Start a tmux session if not in a graphical session
if [[ -z "${DISPLAY}" ]] && [[ -z "${TMUX}" ]] ; then {
    if [[ -x "$(command -v tmux)" ]] ; then {
        exec tmux new
    } fi
} fi

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

# Bash Completions
if [[ -f /usr/share/bash-completion/bash_completion ]]; then {
    source '/usr/share/bash-completion/bash_completion'
} elif [[ -f /etc/bash_completion ]] ; then {
    source '/etc/bash_completion'
} fi


## PSX Prompts

# Define text styles
function __init_styles(){
    # This code is put into a function so it only runs when called by the
    # __set_prompt() function to keep the scope local to the prompt
    
    if [[ -x "$(command -v tput bold)" ]] ; then {
        __bold=$(tput bold) # There is no 'remove bold' tput command
    } else {
        __bold=""
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
    } else {
        __dim=""
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
        # fg_color0=$(tput setaf 0) # Don't need black foreground color
        __fg_color1=$(tput setaf 1)
        __fg_color2=$(tput setaf 2)
        __fg_color3=$(tput setaf 3)
        __fg_color4=$(tput setaf 4)
        __fg_color5=$(tput setaf 5)
        __fg_color6=$(tput setaf 6)
        __fg_color7=$(tput setaf 7)
    } else {
        __fg_color1=""
        __fg_color2=""
        __fg_color3=""
        __fg_color4=""
        __fg_color5=""
        __fg_color6=""
        __fg_color7=""
    } fi
}

function __virtualenv_info(){
    # If there is a virtual environment in the current directory, then
    # activate it and show it in the prompt.
    
    if [[ -n "$VIRTUAL_ENV" ]]; then {
        echo " (venv:\[${__italic}\]${VIRTUAL_ENV##*/}\[${__remove_italic}\])"
    } fi
}

function __git_info(){
    # If the current directory is inside a git repository, then show the
    # current branch in the prompt.

    if git branch &> /dev/null; then {
        echo " (git:\[${__italic}\]$(git rev-parse --abbrev-ref HEAD)\[${__remove_italic}\])"
    } fi
}

function __exit_status(){
    # If the previous process did not return exit code '0', then show an
    # indicator in the prompt.

    if [[ ! $1 == 0 ]] ; then {
        echo "⨉ "
    } fi
}

function __current_dir(){
    # Show the current working directory with '~' replacing the usual
    # '/home/$USER'. If the current working directory has more than four
    # directories in its path, then only show the last three and replace the
    # rest with '.../'. This function handles the current directory. 
    
    local __current_dir
    __current_dir=$( echo "$PWD" | sed 's/\/home\/air/~/g' | rev | cut -d'/' -f-1 | rev )
    echo "${__current_dir}"
}

function __parent_dir(){
    # Show the current working directory with '~' replacing the usual
    # '/home/$USER'. If the current working directory has more than four
    # directories in its path, then only show the last three and replace the
    # rest with '.../'. This function handles the parent directories.
    
    local __parent_dir
    local __depth
    
    __depth=${PWD//[!\/]} # extract the '/' from pwd
    __parent_dir=$( echo "$PWD" | sed 's/\/home\/air/~/g' | rev | cut -d'/' -f-3 | rev )
    
    # There are only a few cases that are possible:
    case ${#__depth} in
        1|2) ;; # Do nothing
        3)      # Only show one parent
            __parent_dir=$( echo "$__parent_dir" | cut -d'/' -f-1 )
            echo "\[${__dim}\]${__parent_dir}/\[${__reset}\]"
            ;;
        4)      # Show two parents
            __parent_dir=$( echo "$__parent_dir" | cut -d'/' -f-2 )
            echo "\[${__dim}\]${__parent_dir}/\[${__reset}\]"
            ;;
        *)      # Show two parents and an ellipsis
            __parent_dir=$(echo "$__parent_dir" | cut -d'/' -f-2 )
            echo "\[${__dim}\].../${__parent_dir}/\[${__reset}\]"
    esac
}

function __window_title(){
    # Set the window title to the current working directory with '~' replacing
    # '/home/$USER'. If the current working directory has more than four
    # directories in its path, then only show the last three and replace the
    # rest with '.../'. The behavior is similar to the __parent_dir() and
    # __current_dir() functions combined.
    
    if [[ $TERM = "alacritty" ]] || [[ $TERM = "xterm-kitty" ]] ; then {

        local __depth

        __depth=${PWD//[!\/]} # extract the '/' from pat

        if (( ${#__depth} > 4 )) ; then { # if there are more than 4 dirs then
            local __parent_dir
            local __current_dir
            __current_dir=$( echo "$PWD" | sed 's/\/home\/air/~/g' | rev | cut -d'/' -f-1 | rev )
            __parent_dir=$( echo "$PWD" | sed 's/\/home\/air/~/g' | rev | cut -d'/' -f-3 | rev | cut -d'/' -f-2 )
            __parent_dir=".../${__parent_dir}/"
            echo "\[$__status_line${__parent_dir}${__current_dir}$__finish_status_line\]"
        } else {
            local __current_path
            __current_path=$( echo "$PWD" | sed 's/\/home\/air/~/g' )
            echo "\[$__status_line\]${__current_path}\[$__finish_status_line\]"
        } fi
    } fi
}

function __set_prompts(){
    # This function is called every time the prompt is shown, getting the
    # necessary variables each time the prompt renders.
    
    # Collect previous exit code for exit_status()
    local exit_code=$? # This has to be the first thing in the function
    
    # Initialize style and color variables defined above so that the variables
    # stay local in scope.
    __init_styles

    # NOTE: "\[" and "\]" are used so that bash can calculate the number of
    # printed characters so that the prompt doesn't do strange things when
    # editing the entered text. Thus, escape all nonprinted characters to
    # avoid any weirdness.
    
    # Not used - displayed after each command, before any output
    PS0=''

    # Normal prompt shown before each command
    PS1="$(__window_title)\[${__fg_color1}${__bold}\]$(__exit_status $exit_code)\[${__fg_color2}\]\u\[${__reset}\]@\[${__bold}${__fg_color3}\]\h\[${__reset}\] \[${__fg_color4}\]$(__parent_dir)\[${__reset}\]\[${__fg_color4}\]$(__current_dir)\[${__fg_color5}\]$(__git_info)\[${__fg_color6}\]$(__virtualenv_info) \[${__fg_color7}${__dim}${__italic}${__bold}\]\$\[${__reset}\] "

    # Secondary prompt when a command needs more input
    PS2="\[${__fg_color1}${__bold}\]$(__exit_status exit_code)\[${__fg_color2}\]\u\[${__reset}\] \[${__fg_color7}${__italic}\]\$\[${__reset}\] "

    # Bash select interactive menus
    PS3='\[${__fg_color7}${__italic}\]Please enter a number from the above list: \[${__reset}\]'

    # Bash prompt used for tracing a script in debug mode
    PS4='\[${__fg_color7}${__italic}\]+\[${__reset}\]' 
}

PROMPT_COMMAND=__set_prompts


## Aliases

# XDG compliance
alias wget='wget --hsts-file="$XDG_CACHE_HOME"/wget-hsts'
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
    
    # Handle Python virtualenvs automatically
    if [[ -x "$(command -v python)" ]] ; then {
        # If python is installed and a parent directory has a virtual
        # environment, then activate it. Otherwise if a virtual environment
        # is active and a parent directory does not contain a virtual
        # environment, then deactivate the active virtual environment.

        for _env_dir in "venv" ".venv" ; do {
            __current_dir=$(realpath .)
            __found=""
            # Recursively search parent directories for _env_dir
            while [[ -z "$__found" ]] && [[ -n "$__current_dir" ]] ; do {
                if [[ -e "$__current_dir/$_env_dir" ]] ; then {
                    __found="$__current_dir/$_env_dir"
                } fi
                __current_dir=${__current_dir%/*}
            } done
        } done

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

# Change to parent directory N times
function change_dir_up {
    local count
    local path

    count=$1
    path=""
    
    if [ -z "${count}" ]; then {
        count=1
    } fi
    
    for i in $(seq 1 "${count}"); do {
        path="${path}../"
    } done
    
    cd $path || exit
}

alias up=change_dir_up

function ipy(){
    if [[ -n "${VIRTUAL_ENV+x}" ]] ; then {
        if . "$VIRTUAL_ENV/bin/activate" ; then {
            ipython --no-banner
            deactivate
            echo
        } fi
    } elif [[ -e "$WORKON_HOME/ipython/bin/activate" ]] ; then  {
        if . "$HOME"/.local/share/virtualenvs/ipython/bin/activate ; then {
            ipython --no-banner
            deactivate
            echo
        } fi
    } fi
}

alias ipython=ipy

# cat
if [[ -x "$(command -v  bat)" ]] ; then { # If bat is installed prefer it
    alias cat="bat --theme=ansi"
} else {
    alias cat="cat --number-nonblank"
} fi

# ncmpcpp
if [[ -x "$(command -v ncmpcpp)" ]] ; then {
    alias mpc="ncmpcpp -s browser --quiet"
} fi

# Minicom
if [[ -x "$(command -v minicom)" ]] ; then {
    alias minicom='minicom --color=on \
        --statlinefmt=" Minicom %V | %b | %T | %D "'
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
