#!/bin/sh
printf "attempt to add oh my zsh"
git submodule add -f https://github.com/robbyrussell/oh-my-zsh ./zsh/.oh-my-zsh
printf "done."
