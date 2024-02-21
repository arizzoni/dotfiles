#!/bin/sh

GET_PASSWORD="$(keepassxc-cli show -s "$HOME/Passwords.kdbx" 'Gmail - aerc' | grep Password: | sed 's/^Password:\ //')"

# wait until the password is available
while [ ! "$GET_PASSWORD" ]; do
	$GET_PASSWORD	
done
