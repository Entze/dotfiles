#!/bin/sh
cd $HOME

printf "installing cask\n"
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
printf "done\n-----\nnow install via pallet-upgrade\n"
