#!/bin/bash

STOWING=$(find . -mindepth 1 -maxdepth 1 -type d -not -wholename "./.*" -exec basename {} \; | tr '\n' ' ' | sed -E "s/[ \t]*$//")

stow --target=$HOME --delete --verbose=1 $STOWING
stow --target=$HOME --verbose=1 $STOWING



