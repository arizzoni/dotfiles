#!/user/bin/env bash
# ~/.config/bash/.bashrc
# version 0.2

# If not running interactively, don't do anything
[[ $- != *i* ]] && return # No need to run the configuration for a script

# PSX Prompts as starship fallback
if [[ ! -x "$(command -v starship)" ]] ; then
    PS0="" # Not used - displayed after each command, before any output
    PS1="\[\e[1;33m\]\u\[\e[0;0m\]@\[\e[1;31m\]\h\[\e[0;37m\] \[\e[1;34m\]\w \
\[\e[3;37m\]$ \[\e[0;0m\]" # Primary output displayed before command
    PS2="\[\e[1;33m\]\u " # Secondary prompt when a command needs more input
    PS3="" # Not used - bash select interactive menus - customized per command
    PS4="" # Not used - bash debug
fi

# GNU Core Utilities Aliases
alias ls="ls --color=auto --group-directories-first --human-readable           \
          --format=long --indicator-style=slash --sort=extension               \
          --time=ctime --time-style=long-iso"
alias du="du --total --human-readable --no-dereference --time=ctime            \
          --time-style=long-iso"
alias cp="cp --interactive --no-clobber --verbose"
alias df="df --human-readable --total --print-type"
alias dir="dir --almost-all --color=auto --format=long --human-readable        \
          --indicator-style=slash --sort=extension --time=ctime                \
          --time-style=long-iso"
alias mv="mv --interactive --no-clobber --verbose"
alias vdir="vdir --color=auto --format=long --group-directories-first          \
            --human-readable --indicator-style=slash --sort=extension          \
            --time=ctime --time-style=long-iso"
alias nl="nl --body-numbering=a --section-delimiter=CC --footer-numbering=a    \
          --header-numbering=a --number-format=rz --no-renumber                \
          --number-width=3"

# Other Aliases
alias eza="eza --color=automatic --color-scale --hyperlink --long --level=2    \
--time-style=long-iso --icons --sort=Extension --group-directories-first --git \
--git-repos"
alias ls="eza"
alias bat="bat --wrap=auto --color=auto --tabs=2 --theme=ansi"

# Ipython Alias
alias ipython="source ~/.ipython/profile_default/ipython/bin/activate;         \
              ~/.ipython/profile_default/ipython/bin/python -m IPython;        \
              deactivate"

# Environment Variables
export EDITOR="nvim" # Export editor variable
export MANPAGER="nvim -c 'Man!' -c 'colo zenwritten'" # Use neovim as a manpager
export STARSHIP_CONFIG="${HOME}/.config/starship/starship.toml"

if [[ -x "$(command -v tmux)" ]] && [[ -n "${DISPLAY}" ]] && [[ -z "${TMUX}" ]]; then
    exec tmux new-session -A -s "${USER}" >/dev/null 2>&1
fi

if [[ -x "$(command -v starship)" ]] ; then
    eval "$(starship init bash)"
fi
