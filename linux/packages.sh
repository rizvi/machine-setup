#!/usr/bin/env bash

# --------------------------------------------------
# Load dependencies
# --------------------------------------------------
cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )"
source $cwd/../shared/config/variables.sh
source $cwd/../shared/lib/utils.sh

# --------------------------------------------------
# Update package cache
# --------------------------------------------------
sudo apt-get update

# --------------------------------------------------
# Upgrade system
# --------------------------------------------------
# sudo apt-get dist-upgrade

# --------------------------------------------------
# SSH
# --------------------------------------------------
if [[ -e $HOME/.ssh/id_rsa ]]; then
  skip "SSH keys"
else
  log "Generating SSH key"
  ssh-keygen -t rsa -b 4096 -C $EMAIL
fi

# --------------------------------------------------
# libssl-devl libreadline-dev zlib1g-dev
# git
# vim
# curl
# checkinstall
# xsel
# nginx
# --------------------------------------------------
sudo apt-get -y install \
  cmake libssl-dev libreadline-dev zlib1g-dev \
  git \
  vim \
  curl \
  checkinstall \
  xsel \
  nginx

# --------------------------------------------------
# PHP
# --------------------------------------------------
if cmd_exists "php"; then
  skip "PHP"
else
  log "Installing $PHP_VERSION"
  sudo add-apt-repository ppa:ondrej/php
  sudo apt-get update
  sudo apt-get -y install "php$PHP_VERSION" "php$PHP_VERSION-mysql" "php$PHP_VERSION-fpm"
fi

# --------------------------------------------------
# Composer
# --------------------------------------------------
if cmd_exists "composer"; then
  skip "Composer"
else
  log "Installing composer"
  EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

  if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then
    >&2 echo 'ERROR: Invalid composer installer signature'
    rm composer-setup.php
    exit 1
  fi

  sudo php composer-setup.php --install-dir=/usr/bin --filename=composer
  rm composer-setup.php
fi

# --------------------------------------------------
# xcape
# --------------------------------------------------
if cmd_exists "xcape"; then
  skip "xcape"
else
  log "Installing xcape"
  sudo apt-get -y install gcc make pkg-config libx11-dev libxtst-dev libxi-dev
  TEMP_DIR=/tmp/xcape
  git clone https://github.com/alols/xcape.git $TEMP_DIR
  cd $TEMP_DIR && make 
  sudo checkinstall -y
  sudo rm -rf $TEMP_DIR
fi

# --------------------------------------------------
# ZSH
# --------------------------------------------------
if [[ $SHELL =~ "zsh" ]]; then
  skip "ZSH"
else
  log "Installing ZSH"
  sudo apt-get -y install zsh
  log "Setting ZSH as default shell"
  chsh -s $(which zsh)
fi

# --------------------------------------------------
# NVM
# --------------------------------------------------
if [[ -e $HOME/.nvm ]]; then
  skip "nvm"
else
  log "Installing nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
fi

# --------------------------------------------------
# Yarn
# --------------------------------------------------
# Some ubuntu versions have 'yarn' package installed by default (https://github.com/yarnpkg/yarn/issues/2821)
if [[ -e $HOME/.cache/yarn ]]; then
  skip "yarn"
else
  log "Installing yarn"
  sudo apt-get -y remove cmdtest yarn
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update && sudo apt-get install -y --no-install-recommends yarn
fi

# --------------------------------------------------
# rbenv
# --------------------------------------------------
if cmd_exists "rbenv"; then
  skip "rbenv"
else
  git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
  mkdir -p "$(rbenv root)"/plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  rbenv install $DEFAULT_RUBY_VERSION && rbenv global $DEFAULT_RUBY_VERSION
  gem install bundler
fi

# --------------------------------------------------
# MySQL
# --------------------------------------------------
if cmd_exists "mysql"; then
  skip "mysql"
else
  log 'Installing MySQL 5.7'
  sudo apt-get -y install mysql-client libmysqlclient-dev mysql-server

  sudo mysql_secure_installation
fi

sudo apt-get -y install mysql-workbench-community

# ---------------------------------------------------
# Docker & Docker Compose
# ---------------------------------------------------
if cmd_exists "docker"; then
    skip "docker"
else
  log 'Installing Docker'

  sudo apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"

  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io

  # Allow non-root usage
  sudo groupadd docker > /dev/null 2>&1
  sudo usermod -aG docker $USER

  # Install docker-compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

# ---------------------------------------------------
# Misc system configuration
# ---------------------------------------------------
# Increase watch count
if [[ "$(cat /proc/sys/fs/inotify/max_user_watches)" =~ "524288" ]]; then
 skip "Watch count already increased"
else
  log "Increasing watch count"
  echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
fi

log "ALL DONE!"
