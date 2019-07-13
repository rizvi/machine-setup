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

log "ALL DONE!"

