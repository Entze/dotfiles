#!/bin/bash

set -exou pipefail

STOWING=$(find . -mindepth 1 -maxdepth 1 -type d -not -wholename "./.*" -exec basename {} \; | tr '\n' ' ' | sed -E "s/[ \t]*$//")


EV=( mkdir -p $HOME/.vim/swap $HOME/.vim/undo $HOME/.vim/backup $HOME/.emacs/backup )
"${EV[@]}"

EV=( stow --target=$HOME --delete --verbose=1 $STOWING )
"${EV[@]}"

EV=( stow --target=$HOME --verbose=1 $STOWING )
"${EV[@]}"
