#!/usr/bin/env zsh

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
  atom
  brew
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
  redis-cli
  ssh-agent
  svn
  terminalapp
)

# Plugin settings
zstyle :omz:plugins:ssh-agent identities id_rsa heroku-ll heroku-personal

source "$ZSH/oh-my-zsh.sh"

# Options
setopt bang_hist # Enable textual history substitution, using !-syntax.

export EDITOR='atom -w'

# Online help for brew-installed zsh
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help


# Aliases
# -------

alias grep='grep --color=auto'
alias feature='git flow feature'
alias release='git flow release'
alias hotfix='git flow hotfix'
alias bgulp='babel-node $(which gulp)'


# Python
# ------

# Virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=true

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/code
pyenv virtualenvwrapper
