#!/bin/sh
cd $HOME/dotfiles/.
printf "attempt to add oh my zsh\n"
cd zsh/.oh-my-zsh/.
git remote rename origin gitlab
git remote add origin https://github.com/robbyrussell/oh-my-zsh
printf "done\n-----\n"
