#!/bin/sh
PKGMNG=eopkg
PKGINSTALL=install
PKGUPGRADE=upgrade
ASSUMEYES=--yes-all
PACKAGES=solus.packages.list
export PKGMNG
export PKGINSTALL
export PKGUPGRADE
export ASSUMEYES
$HOME/dotfiles/install.sh
$HOME/dotfiles/workstation.sh
cd $HOME
