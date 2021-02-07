#!/bin/bash

set -exou pipefail

STOWING=( "git vim zsh" )

EV=( mkdir -p $HOME/.vim/swap $HOME/.vim/undo $HOME/.vim/backup )
"${EV[@]}"

EV=( stow --target=$HOME --delete --verbose=1 $STOWING )
"${EV[@]}"

EV=( stow --target=$HOME --verbose=1 $STOWING )
"${EV[@]}"
