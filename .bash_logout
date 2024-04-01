#!/usr/bin/env bash
# vim: sw=4 ts=4

if [ -x "$(command -v tmux)" ] ; then {
    if [ "$(tmux list-panes | wc -l)" = 1 ] ; then {
        tmux kill-session
    } fi
} fi

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear ] && /usr/bin/clear
fi
