# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
export ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
plugins=(git textmate brew git-flow github osx pip ssh-agent)

source $ZSH/oh-my-zsh.sh

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

# Local bin
if [ -d "$HOME/bin" ] ; then
    path_prepend ${HOME}/bin
fi

# Aliases
alias grep='grep --color=auto'

# Mercurial quirks
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/code/webapps
source /usr/local/share/python/virtualenvwrapper.sh

export TM_PYCHECKER=pyflakes

export EDITOR='mate -w'

export DEPLOY_USER=brandon
export PROJECT_HOME=~/code

