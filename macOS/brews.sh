#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )"

source $DIR/../config/variables.sh
source $DIR/../lib/utils.sh

# --------------------------------------------------
# Homebrew
# --------------------------------------------------
if cmd_exists "brew"; then
  skip "Homebrew"
else
  log "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [[ -e $HOME/.ssh/id_rsa ]]; then
  skip "SSH keys"
else
  log "Generating SSH key"
  ssh-keygen -t rsa -b 4096 -C $EMAIL
fi

# --------------------------------------------------
# ZSH
# --------------------------------------------------
if [[ $SHELL =~ "zsh" ]]; then
  skip "ZSH"
else
  log "Installing ZSH"
  brew install zsh zsh-completions
  sudo echo "$(which zsh)" | sudo tee -a /etc/shells
  chsh -s $(which zsh)
fi

# --------------------------------------------------
# rbenv
# --------------------------------------------------
if cmd_exists "rbenv"; then
  skip "rbenv"
else
  brew install rbenv
  rbenv install $DEFAULT_RUBY_VERSION && rbenv global $DEFAULT_RUBY_VERSION
  gem install bundler
fi

# --------------------------------------------------
# nvm
# --------------------------------------------------
if [[ -e $HOME/.nvm ]]; then
  skip "nvm"
else
  log "Installing nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  nvm install $DEFAULT_NODE_VERSION
fi

# --------------------------------------------------
# Yarn
# --------------------------------------------------
if cmd_exists "yarn"; then
  skip "yarn"
else
  log "Installing yarn"
  brew install yarn --ignore-dependencies
fi

# --------------------------------------------------
# AWS CLI
# --------------------------------------------------
if cmd_exists "aws"; then
  skip "aws"
else
  pip3 install awscli --upgrade --user
fi

# --------------------------------------------------
# Brews
# --------------------------------------------------
install_formula composer
install_formula ffmpeg
install_formula httpd
install_formula hub
install_formula jq
install_formula mysql
install_formula nginx
install_formula openssl
install_formula passenger
install_formula php
install_formula python
install_formula tree
install_formula tmux
install_formula wget
install_formula youtube-dl
