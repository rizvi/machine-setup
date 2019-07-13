#!/bin/bash
function log {
  echo "============================================="
  echo $1
  echo "============================================="
}

$email="sajadtorkamani1@gmail.com"

# log "Installing updates"
# sudo apt-get update && sudo apt-get dist-upgrade

log "Generating SSH key"
if [ -e $HOME/.ssh/id_rsa ]; then
  log "SSH keys already generated. Skipping."
else
  ssh-keygen -t rsa -b 4096 -C email
fi

log "Installing git"
sudo apt-get -y install git

log "Installing vim"
sudo apt-get -y install vim

log "Installing curl"
sudo apt-get -y install curl

log "Installing checkinstall"
sudo apt-get -y install checkinstall

log "Installing xcape"
sudo apt-get -y install gcc make pkg-config libx11-dev libxtst-dev libxi-dev

log "Installing ZSH"
if [[ $SHELL =~ "zsh" ]]; then
  log "ZSH already set up. Skipping."
else
  sudo apt-get -y install zsh
  log "Setting ZSH as default shell"
  chsh -s $(which zsh)
fi


log "ALL DONE!"


