#!/bin/sh

CONNECTED_MONITORS="$(xrandr | grep ' connected ' | sed s/\ connected\ .*//g)"

DP_0="$($CONNECTED_MONITORS | grep DP-0)"
DP_1="$($CONNECTED_MONITORS | grep DP-1)"
eDP_1="$($CONNECTED_MONITORS | grep eDP-1)"
eDP_1_1="$($CONNECTED_MONITORS | grep eDP-1-1)"
DP_1_1="$($CONNECTED_MONITORS | grep DP-1-1)"

if [ -n "$DP_0" ] && [ -n "$DP_1_1" ] && [ -n "$eDP_1_1" ] ; then {
    echo "unconfigured"
}
elif [ -n "$DP_1" ] && [ -n "$eDP_1" ] ; then {
    xrandr --output eDP-1 --mode 1920x1200 --pos 480x2160 --rotate normal --rate 165 --output DP-1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --rate 60
} fi
