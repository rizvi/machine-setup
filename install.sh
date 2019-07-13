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
  log "SSH keys already generated. Skipping"
else
  ssh-keygen -t rsa -b 4096 -C email
fi

log "Installing ZSH"
sudo apt-get -y install zsh

log "Setting ZSH as default shell"
chsh -s $(which zsh)

log "Installing vim"
sudo apt-get -y install vim

log "Installing curl"
sudo apt-get -y install curl

log "Installing checkinstall"
sudo apt-get -y install checkinstall

log "ALL DONE!"


