#!/bin/bash
printf "restoring gitconfig\n"
rm -f -- $HOME/.gitconfig
cd -- $HOME/dotfiles/.
stow --verbose=1 -- git

printf "seting up environment\n"

stow --verbose=1 -- zsh
stow --verbose=1 -- vim
stow --verbose=1 -- emacs


