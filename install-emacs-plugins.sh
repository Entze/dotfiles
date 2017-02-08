#!/bin/sh
cd $HOME

printf "installing cask\n"
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
printf "done\n-----\nnow install via pallet-upgrade\n"

printf "cloning sensible-defaults"
cd $HOME/dotfiles/.
git submodule add -f https://github.com/hrs/sensible-defaults.el ./emacs/.emacs.d/opt/sensible-defaults/.
printf "done\n-----\n"
