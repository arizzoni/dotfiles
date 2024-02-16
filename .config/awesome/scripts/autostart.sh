#!/usr/bin/env sh

# Compositor
if [ -x "$(command -v picom)" ] ; then {
        picom
} fi

# Screen locker
if [ -x "$(command -v light-locker)" ] ; then {
        light-locker --lock-on-suspend --lock-on-lid --idle-hint
} fi
