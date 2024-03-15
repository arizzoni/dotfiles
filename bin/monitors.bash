#!/bin/sh

CONNECTED_MONITORS="$(xrandr | grep ' connected ' | sed s/\ connected\ .*//g)"

DP_0="$($CONNECTED_MONITORS | grep DP-0)"
DP_1="$($CONNECTED_MONITORS | grep DP-1)"
eDP_1="$($CONNECTED_MONITORS | grep eDP-1)"
eDP_1_1="$($CONNECTED_MONITORS | grep eDP-1-1)"
DP_1_1="$($CONNECTED_MONITORS | grep DP-1-1)"

# CONNECTED_MONITORS="$(xrandr | grep ' connected ' | sed s/\ connected\ .*//g)"
#
# for MONITOR in $CONNECTED_MONITORS ; do
# 	DETAILS="$(xrandr -q | grep "$MONITOR" | sed s/"$MONITOR"//g | tr '\n' ' ' | sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g' | tr -s ' ' | sed 's/ /\n/g' )"
# 	X_RESOLUTION="$(echo "$DETAILS" | sed -n '1{p;q}')"
# 	Y_RESOLUTION="$(echo "$DETAILS" | sed -n '2{p;q}')"
# 	X_COORDINATE="$(echo "$DETAILS" | sed -n '3{p;q}')"
# 	Y_COORDINATE="$(echo "$DETAILS" | sed -n '4{p;q}')"
# 	
# 	if [ -n "$X_RESOLUTION" ] ; then {
# 		echo "$MONITOR: $X_RESOLUTION x $Y_RESOLUTION @ ($X_COORDINATE, $Y_COORDINATE)"
# 	} fi
# done


if [ -n "$DP_0" ] && [ -n "$DP_1_1" ] && [ -n "$eDP_1_1" ] ; then {
    xrandr --output DP-0 --mode 2560x1440 --rate 60 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-0 --off --output DP-2 --off --output None-2-1 --off --output eDP-1-1 --mode 1920x1200 --rate 165 --pos 2799x1440 --rotate normal --output DP-1-1 --primary --mode 2560x1440 --rate 60 --pos 2560x0 --rotate normal --output DP-1-2 --off --output DP-1-3 --off --output DP-1-4 --off
}
elif [ -n "$DP_1" ] && [ -n "$eDP_1" ] ; then {
    xrandr --output eDP-1 --mode 1920x1200 --pos 480x2160 --rotate normal --rate 165 --output DP-1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --rate 60
} 
else {
    xrandr --output DP-0 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-0 --off --output DP-2 --off --output None-2-1 --off --output eDP-1-1 --off --output DP-1-1 --primary --mode 2560x1440 --pos 2560x0 --rotate normal --output DP-1-2 --off --output DP-1-3 --off --output DP-1-4 --off
} fi

xbacklight -set 1
