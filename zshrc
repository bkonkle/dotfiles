# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.dotfiles/zsh_custom

# Set name of the theme to load.
export ZSH_THEME="bkonkle"

# Aliases
if [ -f $HOME/.zsh_aliases ]; then
    source $HOME/.zsh_aliases
fi

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

export EDITOR='subl -w'


# ----
# Ruby
# ----

# Initialize rbenv
if [ -f "/usr/local/bin/rbenv" ]; then
    eval "$(rbenv init -)"
fi


# ------
# Python
# ------

# Virtualenv
VIRTUAL_ENV_DISABLE_PROMPT=true

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/code

# Disable global packages in pip
export PIP_RESPECT_VIRTUALENV=true
export PIP_REQUIRE_VIRTUALENV=true
