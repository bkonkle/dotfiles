#!/bin/sh

# This script will take a fresh machine and set it up with a development
# environment. It was adapted from https://github.com/thoughtbot/laptop.
# Thanks for sharing, thoughtbot!

NODE_VERSION="iojs-v3"
RUBY_VERSION="2.2.2"
PYTHON_VERSION="3.4.3"

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

if [ ! -d "$HOME/.bin/" ]; then
  mkdir "$HOME/.bin"
fi

case "$SHELL" in
  */zsh) : ;;
  *)
    fancy_echo "Changing your shell to zsh ..."
    chsh -s "$(which zsh)"
    ;;
esac

brew_install_or_upgrade() {
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      fancy_echo "Upgrading %s ..." "$1"
      brew upgrade "$@"
    else
      fancy_echo "Already using the latest version of %s. Skipping ..." "$1"
    fi
  else
    fancy_echo "Installing %s ..." "$1"
    brew install "$@"
  fi
}

brew_is_installed() {
  local name
  name="$(brew_expand_alias "$1")"

  brew list -1 | grep -Fqx "$name"
}

brew_is_upgradable() {
  local name
  name="$(brew_expand_alias "$1")"

  ! brew outdated --quiet "$name" >/dev/null
}

brew_tap() {
  brew tap "$1" 2> /dev/null
}

brew_expand_alias() {
  brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

brew_launchctl_restart() {
  local name
  name="$(brew_expand_alias "$1")"
  local domain="homebrew.mxcl.$name"
  local plist="$domain.plist"

  fancy_echo "Restarting %s ..." "$1"
  mkdir -p "$HOME/Library/LaunchAgents"
  ln -sfv "/usr/local/opt/$name/$plist" "$HOME/Library/LaunchAgents"

  if launchctl list | grep -Fq "$domain"; then
    launchctl unload "$HOME/Library/LaunchAgents/$plist" >/dev/null
  fi
  launchctl load "$HOME/Library/LaunchAgents/$plist" >/dev/null
}

gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    fancy_echo "Updating %s ..." "$1"
    gem update "$@"
  else
    fancy_echo "Installing %s ..." "$1"
    gem install "$@"
    rbenv rehash
  fi
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

    export PATH="/usr/local/bin:$PATH"
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

fancy_echo "Updating Homebrew formulas ..."
brew update

brew_install_or_upgrade 'zsh'
brew_install_or_upgrade 'git'
brew_install_or_upgrade 'nvm'
brew_install_or_upgrade 'rbenv'
brew_install_or_upgrade 'ruby-build'
brew_install_or_upgrade 'pyenv'
brew_install_or_upgrade 'pyenv-virtualenv'
brew_install_or_upgrade 'pyenv-virtualenvwrapper'

brew_install_or_upgrade 'openssl'
brew unlink openssl && brew link openssl --force

brew_install_or_upgrade 'heroku-toolbelt'
brew_install_or_upgrade 'awscli'
brew_install_or_upgrade 'keybase'
brew_install_or_upgrade 'gnupg'
brew_install_or_upgrade 'shellcheck'
brew_install_or_upgrade 'wget'

if [ ! -d "$HOME/.oh-my-zsh/" ]; then
  fancy_echo "Installing Oh My Zsh ..."
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  fancy_echo "Oh My Zsh already installed. Upgrading ..."
  sh ~/.oh-my-zsh/tools/upgrade.sh
fi

fancy_echo "Installing io.js ..."

export NVM_DIR=~/.nvm
. "$(brew --prefix nvm)"/nvm.sh

nvm install "$NODE_VERSION"

fancy_echo "Istalling Ruby ..."

eval "$(rbenv init - zsh)"

if ! rbenv versions | grep -Fq "$RUBY_VERSION"; then
  rbenv install -s "$RUBY_VERSION"
fi

rbenv global "$RUBY_VERSION"
rbenv shell "$RUBY_VERSION"

gem update --system

gem_install_or_update 'bundler'

fancy_echo "Configuring Bundler ..."
  number_of_cores=$(sysctl -n hw.ncpu)
  bundle config --global jobs $((number_of_cores - 1))

fancy_echo "Installing Python ..."

eval "$(pyenv init - zsh)"

if ! pyenv versions | grep -Fq "$PYTHON_VERSION"; then
  pyenv install -s "$PYTHON_VERSION"
fi

fancy_echo "Installing GUI apps ..."

brew_tap 'caskroom/cask'
brew_install_or_upgrade 'brew-cask'

brew cask install 1password
brew cask install arq
brew cask install atom
brew cask install cyberduck
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install google-drive
brew cask install kaleidoscope
brew cask install razer-synapse
brew cask install seil
brew cask install tower
brew cask install vagrant
brew cask install virtualbox
