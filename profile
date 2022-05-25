#!/bin/sh

export LANG=en_CA.UTF-8
export EMAIL=james@overdrivenetworks.com
export EDITOR=nano
export DEBFULLNAME="James Lu"
export WINEPREFIXROOT="$HOME/.local/share/wineprefixes"

if [ -d "$HOME/.local/bin" ]; then
	export PATH="${HOME}/.local/bin:${PATH}"
fi
