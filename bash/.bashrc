#!/user/bin/env bash
# ~/.config/bash/.bashrc
# version 0.2

# If not running interactively, don't do anything
[[ $- != *i* ]] && return # No need to run the configuration for a script

# PSX Prompts
source "$HOME/.config/bash/prompt.bash"

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

# if [[ -x "$(command -v tmux)" ]] &&                                            \
#     [[ -n "${DISPLAY}" ]] &&                                                   \
#     [[ -z "${TMUX}" ]] ; then
#     exec tmux new-session -A -s "${USER}" >/dev/null 2>&1
# fi
