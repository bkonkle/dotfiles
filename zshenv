#!/usr/bin/env zsh

# ZSH Environment Configuration
# =============================
#
# This file is sourced for all login shells, whether interactive or not. It's
# the best place to set up path details, so that tools like Sublime Text can
# find things.

# Path setup
# ----------

# Convenience functions for path manipulation
path_append()  { path_remove $1; export PATH="$PATH:$1"; }
path_prepend() { path_remove $1; export PATH="$1:$PATH"; }
path_remove()  { export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'`; }

# Prepend local bin and sbin
path_prepend /usr/local/sbin
path_prepend /usr/local/bin

# Local bin
if [ -d "$HOME/bin" ] ; then
    path_prepend $HOME/bin
fi

if [ -d "$HOME/.local/bin" ] ; then
    path_prepend $HOME/.local/bin
fi

if [ -d "/home/linuxbrew" ] ; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

export DOCKER_HOST=ssh://brandon@dev.knkl.us

# Locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Perl
# ----

# Homebrew perl path
export PERL5LIB="$PERL5LIB:/usr/local/lib/perl5/site_perl"
