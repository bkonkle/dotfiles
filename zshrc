#!/usr/bin/env zsh

# ZSH Interactive Shell Configuration
# ===================================
#
# This file is sourced for all interactive shells. It's the best place to set
# up details that wouldn't be useful to software accessing the shell
# programatically.

# Antigen ZSH package manager
if [[ `uname` == 'Darwin' ]]; then
  source $(brew --prefix)/share/antigen/antigen.zsh
elif [[ `uname` == 'Linux' ]]; then
  source /usr/share/zsh-antigen/antigen.zsh
fi

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

if [[ `uname` == 'Darwin' ]]; then
  antigen bundle atom
  antigen bundle brew
  antigen bundle osx
fi

antigen theme tylerreckart/hyperzsh hyperzsh

antigen apply

# Plugin settings
zstyle :omz:plugins:ssh-agent identities id_rsa heroku-personal

# Options
setopt bang_hist # Enable textual history substitution, using !-syntax.

export EDITOR='vim'

if [[ `uname` == 'Darwin' ]]; then
  # Online help for brew-installed zsh
  unalias run-help
  autoload run-help
  HELPDIR=/usr/local/share/zsh/help
fi

# Aliases
# -------

alias grep='grep --color=auto'
alias n='PATH=$(npm bin):$PATH'


# Python
# ------

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/code

if which virtualenvwrapper.sh > /dev/null; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

if [[ `uname` == 'Darwin' ]]; then
  # Google Cloud
  # ------------
  source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
  source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

# OPAM configuration
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/brandon/code/pairboard-desktop/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/brandon/code/pairboard-desktop/node_modules/tabtab/.completions/electron-forge.zsh


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
