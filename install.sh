#!/usr/bin/env bash
# This script installs the configured dotfiles in this directory into your home folder.
# It will interactively check to see if files exist, and prompt you on whether you want
# to overwrite them.

# Everything is done via symlinks for convenient editing and updates.

help () {
	echo "Usage: $BASH_SOURCE [-h/--help] FILE"
	echo "Installs FILE if given and present, otherwise installs all files defined in the $dotfiles variable in source."
	exit 0
}

for item in '-h' '--help'; do
    [[ "$1" == "$item" ]] && help
done

if [ -z "$1" ]; then # If no argument is given
	dotfiles=(bashrc screenrc bash_profile bash_aliases gitconfig profile)
else
	if [ -f "$1" ]; then
		dotfiles=($1)
	else
		echo "no such file \"$1\", aborting..."
		exit 1
	fi
fi

for x in "${dotfiles[@]}"; do
	origin="$(pwd)/${x}"
	for target in ${HOME}/.${x}; do
		echo ""
		if [ -e $target ] || [ -L $target ]; then
			echo "${target} already exists. Replace it? "
			rm -i $target
		fi
		echo Symlinking $x to ${target};
		ln -s ${origin} ${target} && echo -e "\nDone.";
	done
done
