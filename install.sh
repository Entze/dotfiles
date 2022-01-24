#!/bin/bash

set -exou pipefail


mkdir -p "$HOME"/.vim/swap "$HOME"/.vim/undo "$HOME"/.vim/backup

stow --target="$HOME" --delete --verbose=1 git
stow --target="$HOME" --delete --verbose=1 vim
stow --target="$HOME" --delete --verbose=1 zsh
stow --target="$HOME" --delete --verbose=1 emacs
stow --target="$HOME" --delete --verbose=1 python

stow --target="$HOME" --verbose=1 git
stow --target="$HOME" --verbose=1 vim
stow --target="$HOME" --verbose=1 zsh
stow --target="$HOME" --verbose=1 emacs
stow --target="$HOME" --verbose=1 python
