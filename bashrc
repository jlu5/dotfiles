# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-*color) color_prompt=yes;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
# update the window size after each command
shopt -s checkwinsize
shopt -s globstar

# We need ncurses' tput under FreeBSD; otherwise color checking refuses to work.
# It is installed as /usr/local/bin/tput via ports.
if [[ "$(uname)" == "FreeBSD" ]]; then
	tput_path="/usr/local/bin/tput"
else
	tput_path="$(which tput)"
fi

if [ -x $tput_path ]; then
	if $tput_path setaf 1 >&/dev/null ; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
else
	echo "shellcolor: 'tput' (at $tput_path), used to detect whether this terminal supports color, is not available on the system. Try installing ncurses?"
	color_prompt=
fi

# Hash shell color based on hostname, falling back to green if it fails
if [ "$color_prompt" = yes ]; then
	if [[ "$(id -u)" == 0 ]]; then
		color='91'
	else
		if [[ -f "$HOME/.color_hash" ]]; then
			color=$(cat "$HOME/.color_hash")
		else
			echo 'shellcolor: First run, hashing hostname color to ~/.color_hash'
			color=$(python3 -c "print(__import__('random').choice(('95', '96', '92', '93', '97')))")
			if [ ! -z "$color" ]; then
				echo -e "shellcolor: Color set to \033[${color}m${color}\033[00m, saving..."
				echo "$color" > "$HOME/.color_hash"
			else
				color='92'
				echo 'shellcolor: Hashing failed, failing back to default.'
			fi
		fi
	fi

	PS1='\[\033[${color}m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	# Enable colors in FreeBSD's "ls"
	export CLICOLOR="YES"
	# (For FreeBSD) Set the LS_COLORS to match Linux (GNU coreutils)
	export LSCOLORS="ExGxcxdxCxegedCxCxExEx"
else
	PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PS1="\[\e]0;\u@\h: \w\a\]$PS1"
	;;
*)
	;;
esac

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
  fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi
