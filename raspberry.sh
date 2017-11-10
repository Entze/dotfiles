#!/bin/sh
PKGMNG=apt-get
PKGINSTALL=install
PKGUPGRADE=update && apt-get upgrade
ASSUMEYES=-y
export PKGMNG
export PKGINSTALL
export PKGUPGRADE
export ASSUMEYES
$HOME/dotfiles/install.sh
$HOME/dotfiles/headless.sh
cd $HOME/dotfiles
stow --verbose=1 raspberry
cd $HOME
