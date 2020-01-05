#!/bin/bash

STOWING=$(find . -mindepth 1 -maxdepth 1 -type d -not -wholename "./.*" -exec basename {} \; | tr '\n' ' ' | sed -E "s/[ \t]*$//")

printf "mkdir -p $HOME/.vim/swap $HOME/.vim/undo $HOME/.vim/backup\n"
mkdir -p $HOME/.vim/swap $HOME/.vim/undo $HOME/.vim/backup

printf "stow --target=$HOME --delete --verbose=1 $STOWING"
stow --target=$HOME --delete --verbose=1 $STOWING
printf "stow --target=$HOME --verbose=1 $STOWING"
stow --target=$HOME --verbose=1 $STOWING

