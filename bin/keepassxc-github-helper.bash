#!/bin/sh

# secret-tool lookup "$1" "$2"
# # wait until the password is available
# while [ $? != 0 ]; do
# 	secret-tool lookup "$1" "$2"
# done

keepassxc-cli show -s "$HOME/Passwords.kdbx" 'Github' | grep Password: | sed "s/^Password:\ //"
# wait until the password is available
while [ $? != 0 ]; do
	keepassxc-cli show -s "$HOME/Passwords.kdbx" 'Github' | grep Password: | sed "s/^Password:\ //"
done
