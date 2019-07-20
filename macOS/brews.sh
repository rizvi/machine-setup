#!/bin/bash

# ---------------------------------------------------
# Utility functions
# ---------------------------------------------------
# Pretty print a message.
function log {
  echo -e "\n"
  echo "============================================="
  echo $1
  echo "============================================="
}

# Check if a cmd exists.
function cmd_exists {
  command -v $1 > /dev/null 2>&1
}

# Log a skiping message.
function skip {
 log "$1 already exists. Skipping"
}


# ---------------------------------------------------
# Variables
# ---------------------------------------------------
EMAIL="sajadtorkamani1@gmail.com"
DOTFILES_DIR=$HOME/.config/dotfiles
DEFAULT_RUBY_VERSION="2.6.3" # The Ruby version to install
DEFAULT_NODE_VERSION="v10.16.0"


# Install Homebrew
if cmd_exists "brew"; then
  skip "Homebrew"
else
  log "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ -e $HOME/.ssh/id_rsa ]; then
  skip "SSH keys"
else
  log "Generating SSH key"
  ssh-keygen -t rsa -b 4096 -C $EMAIL
fi

if [[ $SHELL =~ "zsh" ]]; then
  skip "ZSH"
else
  log "Installing ZSH"
  brew install zsh zsh-completions
  sudo echo "$(which zsh)" | sudo tee -a /etc/shells
  chsh -s $(which zsh)
fi

if cmd_exists "rbenv"; then
  skip "rbenv"
else
  brew install rbenv
  rbenv install $DEFAULT_RUBY_VERSION && rbenv global $DEFAULT_RUBY_VERSION
  gem install bundler
fi

if [[ -e $HOME/.nvm ]]; then
  skip "nvm"
else
  log "Installing nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  nvm install $DEFAULT_NODE_VERSION
fi

if cmd_exists "yarn"; then
  skip "yarn"
else
  log "Installing yarn"
  brew install yarn --ignore-dependencies
fi

brew install wget
brew install mysql
brew install php
brew install composer
brew install nginx

