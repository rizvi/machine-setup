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

# ---------------------------------------------------
# Setup dotfiles
# ---------------------------------------------------
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

if [[ -e $HOME/.bashrc ]]; then
  skip ".bashrc"
else
  log "Setting up .bashrc"
  ln -s $DOTFILES_DIR/bashrc $HOME/.bashrc
fi

if [[ -e $HOME/.inputrc ]]; then
  skip ".inputrc"
else
  log "Setting up .inputrc"
  ln -s $DOTFILES_DIR/inputrc $HOME/.inputrc
fi

if [[ -e $HOME/.oh-my-zsh ]]; then
  skip "Oh My Zsh"
else
  log "Installing Oh My Zsh"
  git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
  ln -s $DOTFILES_DIR/aliases $HOME/.oh-my-zsh/custom/aliases.zsh
fi

if [[ -e $HOME/.vimrc ]]; then
  skip ".vimrc"
else
  log "Setting up .vimrc"
  ln -s $DOTFILES_DIR/vimrc $HOME/.vimrc
fi

if [[ -e $HOME/.vim ]]; then
  skip ".vim"
else
  log "Setting up .vim/"
  ln -s $DOTFILES_DIR/vim $HOME/.vim
fi

if [[ -e $HOME/.gitignore_global ]]; then
  skip ".gitignore_global"
else
  log "Setting up .gitignore_globa$HOME"
  ln -s $DOTFILES_DIR/gitignore_global $HOME/.gitignore_global
  git config --global core.excludesfile $HOME/.gitignore_global
fi
# ---------------------------------------------------
