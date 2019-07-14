#!/bin/bash

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

function skip {
 log "$1 already exists. Skipping"
}

# Variables
EMAIL="sajadtorkamani1@gmail.com"
DOTFILES_DIR=$HOME/.config/dotfiles

# log "Installing updates"
# sudo apt-get update && sudo apt-get dist-upgrade

log "Installing cmake"
sudo apt-get -y install cmake

log "Generating SSH key"
if [ -e $HOME/.ssh/id_rsa ]; then
  log "SSH keys already generated. Skipping."
else
  ssh-keygen -t rsa -b 4096 -C $EMAIL
  eval "$(ssh-agent -s)"
  ssh-add $HOME/.ssh/id_rsa
fi

log "Installing git"
sudo apt-get -y install git

log "Installing vim"
sudo apt-get -y install vim

log "Installing curl"
sudo apt-get -y install curl

log "Installing checkinstall"
sudo apt-get -y install checkinstall

log "Installing xsel"
sudo apt-get -y install xsel

if cmd_exists "xcape"; then
  log "xcape already installed. Skipping"
else
  log "Installing xcape"
  sudo apt-get -y install gcc make pkg-config libx11-dev libxtst-dev libxi-dev
  TEMP_DIR=/tmp/xcape
  git clone https://github.com/alols/xcape.git $TEMP_DIR
  cd $TEMP_DIR && make 
  sudo checkinstall -y
  sudo rm -rf $TEMP_DIR
fi

if [[ $SHELL =~ "zsh" ]]; then
  log "ZSH already set up. Skipping."
else
  log "Installing ZSH"
  sudo apt-get -y install zsh
  log "Setting ZSH as default shell"
  chsh -s $(which zsh)
fi

if [[ -d $DOTFILES_DIR ]]; then
  log "dotfiles already installed. Skipping"
else
  log "Downloading dotfiles"
  git clone git@github.com:sajadtorkamani/dotfiles.git $DOTFILES_DIR
fi

if [[ -e $HOME/.zshrc ]]; then
  log ".zshrc already exists. Skipping"
else
  log "Setting up .zshrc"
  sudo ln -s $DOTFILES_DIR/zshrc $HOME/.zshrc
fi

if [[ -e $HOME/.bashrc ]]; then
  log ".bashrc already exists. Skipping"
else
  log "Setting up .bashrc"
  sudo ln -s $DOTFILES_DIR/bashrc $HOME/.bashrc
fi

if [[ -e $HOME/.oh-my-zsh ]]; then
  log "Oh My Zsh already setup. Skipping"
else
  log "Installing Oh My Zsh"
  git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
  sudo ln -s $DOTFILES_DIR/aliases $HOME/.oh-my-zsh/custom/aliases.zsh
fi

if [[ -e $HOME/.vimrc ]]; then
  skip ".vimrc"
else
  log "Setting up .vimrc"
  sudo ln -s $DOTFILES_DIR/vimrc $HOME/.vimrc
fi

if [[ -e $HOME/.nvm ]]; then
  skip "nvm"
else
  log "Installing nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
fi

# Some ubuntu versions have 'yarn' package installed by default
# (https://github.com/yarnpkg/yarn/issues/2821)
if [[ -e $HOME/.cache/yarn ]]; then
  skip "yarn"
else
  log "Installing yarn"
  sudo apt-get -y remove cmdtest yarn
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update && sudo apt-get install -y --no-install-recommends yarn
fi

log "ALL DONE!"


