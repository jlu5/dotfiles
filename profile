#!/bin/sh

export LANG=en_CA.UTF-8
export EMAIL="ja"mes@"overdr"ivenetwo"rks.com"
export DEBEMAIL="jl"u@"debi"an.org
export EDITOR=nano
export DEBFULLNAME="James Lu"
export WINEPREFIXROOT="$HOME/.local/share/wineprefixes"

if [ -d "$HOME/.local/bin" ]; then
	export PATH="${HOME}/.local/bin:${PATH}"
fi
