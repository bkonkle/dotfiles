#!/usr/bin/env zsh

# ZSH Interactive Shell Configuration
# ===================================
#
# This file is sourced for all interactive shells. It's the best place to set
# up details that wouldn't be useful to software accessing the shell
# programatically.

# Antigen ZSH package manager
source /usr/local/share/antigen/antigen.zsh

# Oh My ZSH
antigen use oh-my-zsh

# Plugins
antigen bundles <<BUNDLES
command-not-found
colored-man-pages
gem
git
git-remote-branch
github
golang
gpg-agent
heroku
npm
redis-cli
ssh-agent

zsh-users/zsh-autosuggestions
zsh-users/zsh-completions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search

tylerreckart/hyperzsh
BUNDLES

antigen theme tylerreckart/hyperzsh hyperzsh

antigen apply

# Plugin settings
zstyle :omz:plugins:ssh-agent identities id_rsa heroku-personal

# Options
setopt bang_hist # Enable textual history substitution, using !-syntax.

export EDITOR='vim'

# Aliases
# -------

alias grep='grep --color=auto'
alias n='PATH=$(npm bin):$PATH'
alias code='code-insiders'

# Project-Specific
# ----------------

export NPM_TOKEN=f55d39ac-85a3-43af-8fc9-c975e84d4646
export GITHUB_NPM_AUTH_TOKEN=8bd7b713e7eb6118ee95a148274f6a073d31d22a

# Node.js
# -------

# Yarn globals
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# Python
# ------

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/code

if which virtualenvwrapper.sh > /dev/null; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

# OCaml
# -----

# OPAM configuration
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Hashicorp Vault config
export VAULT_ADDR=https://vault.communityfunded.io:8200
export VAULT_SKIP_VERIFY=true

# Less paging tweaks
export LESS="-SRXF"
