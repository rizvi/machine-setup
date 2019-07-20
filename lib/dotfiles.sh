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


# ---------------------------------------------------
# Variables
# ---------------------------------------------------
DOTFILES_DIR=$HOME/.config/dotfiles

if [[ -d $DOTFILES_DIR ]]; then
  skip "dotfiles"
else
  log "Downloading dotfiles"
  git clone git@github.com:sajadtorkamani/dotfiles.git $DOTFILES_DIR
fi

if [[ -e $HOME/.zshrc ]]; then
  skip ".zshrc"
else
  log "Setting up .zshrc"
  ln -s $DOTFILES_DIR/zshrc $HOME/.zshrc
fi
