#!/bin/sh

ZPREZTO_DIR="${ZDOTDIR:-$HOME}/.zprezto"

echo "Installing/Updating zprezto in $ZPREZTO_DIR..."

(
  if [ ! -e $ZPREZTO_DIR/.git ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git $ZPREZTO_DIR
  else
    git pull
  fi
  
  cd $ZPREZTO_DIR
  git submodule sync --recursive
  git submodule update --init --recursive
) | sed 's/^/    /';
