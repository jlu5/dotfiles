# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -f "$HOME/.profile" ] ; then
	. "$HOME/.profile"
fi

# start gpg-agent if not running
# if test -f $HOME/.gpg-agent-info && kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2> /dev/null; then
#     GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info`
#     export GPG_AGENT_INFO
# else
#     eval `gpg-agent --default-cache-ttl 4294967295 --daemon --enable-ssh-support --write-env-file ~/.gpg-agent-info`
# fi

# if [ -f "${HOME}/.gpg-agent-info" ]; then
#     . "${HOME}/.gpg-agent-info"
#     export GPG_AGENT_INFO
#     export SSH_AUTH_SOCK
#     export SSH_AGENT_PID
# fi

# GPG_TTY=$(tty)
# export GPG_TTY
