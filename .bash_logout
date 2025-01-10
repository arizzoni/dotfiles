#!/usr/bin/env bash

# Kill the tmux session on shell exit
if [ -x "$(command -v tmux)" ]; then {
    if [ "$(tmux list-panes | wc -l)" = 1 ]; then {
        tmux kill-session
    }; fi
}; fi

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear ] && /usr/bin/clear
fi
