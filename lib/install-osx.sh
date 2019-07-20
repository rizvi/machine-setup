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


# Install Homebrew
if cmd_exists "brew"; then
  skip "Homebrew"
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ -e $HOME/.ssh/id_rsa ]; then
  skip "SSH keys"
else
  log "Generating SSH key"
  ssh-keygen -t rsa -b 4096 -C $EMAIL
fi
