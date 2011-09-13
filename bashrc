# ~/.bashrc: executed by bash(1) for non-login shells.

# Convenience functions for path manipulation
path_append()  { path_remove $1; export PATH="$PATH:$1"; }
path_prepend() { path_remove $1; export PATH="$1:$PATH"; }
path_remove()  { export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'`; }

# Prepend local bin and sbin 
path_prepend /usr/local/sbin
path_prepend /usr/local/bin

# Locally installed Ruby gems
if [ -r "${HOME}/.gem/ruby/1.8/bin" ]; then
    path_prepend ${HOME}/.gem/ruby/1.8/bin
fi

# Scripts installed by the Homebrew python
if [ -d "/usr/local/share/python" ]; then
    path_prepend /usr/local/share/python
fi

# Homebrew perl path
export PERL5LIB="$PERL5LIB:/usr/local/lib/perl5/site_perl"

# If not running interactively, don't do anything else
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features
if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

# Added for Mercurial
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/code/webapps
source /usr/local/bin/virtualenvwrapper.sh

export TM_PYCHECKER=pyflakes

export EDITOR='mate -w'

export DEPLOY_USER=brandon
export PROJECT_HOME=~/code

# Add SSH identity to the authentication agent
ssh-add &> /dev/null

export PIP_REQUIRE_VIRTUALENV=true
export PIP_RESPECT_VIRTUALENV=true
