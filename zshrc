# ZSH Interactive Shell Configuration
# ===================================
#
# This file is sourced for all interactive shells. It's the best place to set
# up details that wouldn't be useful to software accessing the shell
# programatically.

# Oh My ZSH
#-----------

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.dotfiles/zsh_custom

# Set name of the theme to load.
export ZSH_THEME="bkonkle"

# Which plugins would you like to load?
plugins=(
  brew
  cloudapp
  django
  fabric
  gem
  git
  git-flow
  git-remote-branch
  github
  golang
  gpg-agent
  heroku
  npm
  osx
  pip
  python
  redis-cli
  ssh-agent
  sublime
  svn
  terminalapp
)

# Plugin settings
zstyle :omz:plugins:ssh-agent identities id_rsa heroku-ll heroku-personal

source $ZSH/oh-my-zsh.sh

# Options
setopt bang_hist # Enable textual history substitution, using !-syntax.

export EDITOR='atom -w'


# Aliases
# -------

alias grep='grep --color=auto'
alias feature='git flow feature'
alias release='git flow release'
alias hotfix='git flow hotfix'
alias fab='nocorrect fab'
alias gulph='node --harmony `which gulp`'


# Python
# ------

# Virtualenv
VIRTUAL_ENV_DISABLE_PROMPT=true

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/code
source /usr/local/bin/virtualenvwrapper.sh


# Fun
# ---

t timeline -d -n1 | cowsay | lolcat
