#!/usr/bin/env bash

# --------------------------------------------------
# Load dependencies
# --------------------------------------------------
cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )"
source $cwd/config/variables.sh
source $cwd/lib/utils.sh

# --------------------------------------------------
# Symlink dotfile
# --------------------------------------------------
function symlink_dotfile {
  if [[ -e "$HOME/$1" ]]; then
    skip $1
  else
    log "Setting up $1"
    ln -s "$DOTFILES_DIR/$1" "$HOME/$1"
  fi
}

# --------------------------------------------------
# Download dotfiles repo
# --------------------------------------------------
if [[ -d $DOTFILES_DIR ]]; then
  skip "dotfiles"
else
  log "Downloading dotfiles"
  git clone git@github.com:sajadtorkamani/dotfiles.git $DOTFILES_DIR
fi

# --------------------------------------------------
# List of dotfiles to symlink
# --------------------------------------------------
dotfiles=(
  ".bashrc"
  ".inputrc"
  ".rspec"
  ".tmux.conf"
  ".vim"
  ".vimrc"
  ".zshrc"
)

for dotfile in "${dotfiles[@]}"
do
  symlink_dotfile $dotfile
done

# --------------------------------------------------
# Gitignore global
# --------------------------------------------------
if [[ -e $HOME/.gitignore_global ]]; then
  skip ".gitignore_global"
else
  log "Setting up .gitignore_global"
  ln -s $DOTFILES_DIR/.gitignore_global $HOME/.gitignore_global
  git config --global core.excludesfile $HOME/.gitignore_global
fi

# --------------------------------------------------
# Tmux
# --------------------------------------------------
if [[ -e $HOME/.tmux ]]; then
  skip ".tmux"
else
  log "Setting up .tmux"
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

# --------------------------------------------------
# Oh My ZSH
# --------------------------------------------------
if [[ -e $HOME/.oh-my-zsh ]]; then
  skip "Oh My Zsh"
else
  log "Installing Oh My Zsh"
  git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
  ln -s $DOTFILES_DIR/aliases $HOME/.oh-my-zsh/custom/aliases.zsh
fi

# --------------------------------------------------
# SSH config
# --------------------------------------------------
if [[ -e $HOME/.ssh/config ]]; then
  skip "ssh config"
else
  log "Setting up ssh config"
  ln -s $DOTFILES_DIR/ssh_config $HOME/.ssh/config
fi
