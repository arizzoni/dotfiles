#!/user/bin/env bash
# ~/.config/bash/.bashrc
# version 0.2

# If not running interactively, don't do anything
[[ $- != *i* ]] && return # No need to run the configuration for a script

# PSX Prompts as starship fallback
# if [[ ! -x "$(command -v starship)" ]] ; then
source "$HOME/.config/bash/prompt.bash"
# fi

# GNU Core Utilities Aliases
alias ls="ls --color=auto --group-directories-first --human-readable           \
          --format=long --indicator-style=slash --sort=extension               \
          --time=ctime --time-style=long-iso"
alias du="du --total --human-readable --no-dereference --time=ctime            \
          --time-style=long-iso"
alias cp="cp --interactive --verbose"
alias df="df --human-readable --total --print-type"
alias dir="dir --almost-all --color=auto --format=long --human-readable        \
          --indicator-style=slash --sort=extension --time=ctime                \
          --time-style=long-iso"
alias mv="mv --interactive --verbose"
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
alias la="eza -a"
alias bat="bat --wrap=auto --color=auto --tabs=2 --theme=ansi"
alias lite="lite-xl"
alias rct="openrct2"

# Ipython Alias
alias ipython="source ~/.ipython/profile_default/ipython/bin/activate;         \
              ~/.ipython/profile_default/ipython/bin/python -m IPython;        \
              deactivate"

# Environment Variables
export EDITOR="nvim" # Export editor variable
export MANPAGER="nvim -c 'Man!' -c 'colo zenwritten'" # Use neovim as manpager

if [[ -x "$(command -v wal)" ]] ; then
    wal -Rwq
fi

if [[ -x "$(command -v tmux)" ]] &&                                            \
    [[ -n "${DISPLAY}" ]] &&                                                   \
    [[ -z "${TMUX}" ]] ; then
    exec tmux new-session -A -s "${USER}" >/dev/null 2>&1
fi
