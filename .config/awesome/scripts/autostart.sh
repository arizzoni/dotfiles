#!/usr/bin/sh

# Compositor
if [ -x "$(command -v picom)" ] ; then {
        picom &
} fi

# Screen locker
if [ -x "$(command -v light-locker)" ] ; then {
        light-locker --lock-on-suspend --lock-on-lid --no-late-locking &
} fi

# KeepassXC
if [ -x "$(command -v keepassxc)" ] ; then {
        keepassxc &
} fi
