#!/bin/sh
cd ./zsh/.oh-my-zsh
git submodule add -f https://github.com/bhilburn/powerlevel9k.git ./custom/themes/powerlevel9k
cp -f ../../upgrade.sh ./tools/upgrade.sh
