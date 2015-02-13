# ZSH Environment Configuration
# =============================
#
# This file is sourced for all shells, whether interactive or not. It's the
# best place to set up path details, so that tools like Sublime Text can find
# things.

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

# Locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Python
# ------

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Perl
# ----

# Homebrew perl path
export PERL5LIB="$PERL5LIB:/usr/local/lib/perl5/site_perl"

# Node.js
# -------

export NODE_PATH=/usr/local/lib/node_modules
export NODE_ENV=development

# Ruby
# ----

if [ -d "/usr/local/opt/ruby/bin" ]; then
    path_prepend /usr/local/opt/ruby/bin
fi

# Java
# ----

export JAVA_HOME=$(/usr/libexec/java_home)
export CATALINA_HOME=/usr/local/opt/tomcat/libexec