# Load Git functions
source "$HOME/bin/git-prompt.sh"

function __virtualenv_info(){
        if [[ -n "$VIRTUAL_ENV" ]]; then
                venv="${VIRTUAL_ENV##*/}"
        else
                venv=''
        fi
        [[ -n "$venv" ]] && echo " (venv:$venv)"
}

function __set_prompt(){
        # Create a string like:  "[ Apr 25 16:06 ]" with time in RED.
        printf -v PS1RHS "\e[0m\e[0;1;32m%(%T)T \e[0;1;31m%(%F)T\e[0m" -1 # -1 is current time

        # Strip ANSI commands before counting length
        # From: https://www.commandlinefu.com/commands/view/12043/remove-color-special-escape-ansi-codes-from-text-with-sed
        PS1RHS_stripped=$(sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" <<<"$PS1RHS") # TODO refactor if possible

        # Reference: https://en.wikipedia.org/wiki/ANSI_escape_code
        local Save='\e[s' # Save cursor position
        local Rest='\e[u' # Restore cursor to save point

        # Save cursor position, jump to right hand edge, then go left N columns where
        # N is the length of the printable RHS string. Print the RHS string, then
        # return to the saved position and print the LHS prompt.

        # Note: "\[" and "\]" are used so that bash can calculate the number of
        # printed characters so that the prompt doesn't do strange things when
        # editing the entered text.
        PS0='' # Not used - displayed after each command, before any output
        PS1='\[\e[1;33m\]\[\e[1;33m\]\u\[\e[0;0m\]@\[\e[1;31m\]\h\[\e[0;37m\] \[\e[1;34m\]\w\[\e[0;35m\]$(__git_ps1 " (git:%s)") \[\e[0;35m\]$(__virtualenv_info)\[\e[3;37m\]$ \[\e[0;0m\]' # Primary output displayed before command
        PS2='\[\e[1;33m\]\u ' # Secondary prompt when a command needs more input
        PS3='' # Not used - bash select interactive menus - customized per command
        PS4='' # Not used - bash debug
        PS1="\[${Save}\e[${COLUMNS:-$(tput cols)}C\e[${#PS1RHS_stripped}D${PS1RHS}${Rest}\]${PS1}"
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

PROMPT_COMMAND=__set_prompt
