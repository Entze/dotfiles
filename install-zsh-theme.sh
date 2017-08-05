#!/bin/sh
cd $HOME/dotfiles/zsh/.oh-my-zsh/custom/themes/lambda-mod/.
git remote rename origin gitlab
git remote add origin https://github.com/halfo/lambda-mod-zsh-theme
