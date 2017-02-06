#!/bin/sh
cd ~

printf "installing cask\n"
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
printf "done\nnow install via pallet-upgrade"

printf "cloning sensible-defaults"
git clone https://github.com/hrs/sensible-defaults.el ~/.emacs.d/opt/sensible-defaults/.
printf "done\n"
