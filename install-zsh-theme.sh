#!/bin/sh
cd ~/dotfiles/zsh/.oh-my-zsh
git submodule add -f https://github.com/bhilburn/powerlevel9k.git ./custom/themes/powerlevel9k
printf "attempt to copy the patched upgrade file\n"
cp -f ../../upgrade.sh ./tools/upgrade.sh
printf "done\n"
