#!/bin/bash

SOURCEDIR="home/"

tree "$SOURCEDIR" -a

read -p "Are you sure? This will overwrite the above files in your home directory. (y/N)? " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
	rsync -a --progress "$SOURCEDIR" "$HOME"
else
	echo 'Exiting...'
fi
