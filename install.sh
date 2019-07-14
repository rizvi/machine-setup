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

log "Generating SSH key"
if [ -e $HOME/.ssh/id_rsa ]; then
  log "SSH keys already generated. Skipping."
else
  ssh-keygen -t rsa -b 4096 -C $EMAIL
fi

log "Installing git"
sudo apt-get -y install git

log "Installing vim"
sudo apt-get -y install vim

log "Installing curl"
sudo apt-get -y install curl

log "Installing checkinstall"
sudo apt-get -y install checkinstall

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
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
  rm $HOME/.zshrc.pre-oh-my-zsh # Remove backup file created by Oh My Zsh install script
  sudo ln -s $DOTFILES_DIR/zshrc $HOME/.zshrc
fi

if -e $HOME/.vimrc; then
  skip ".vimrc"
else
  log "Setting up .vimrc"
  sudo ln -s $DOTFILES_DIR/vimrc $HOME/.vimrc
fi

log "ALL DONE!"


