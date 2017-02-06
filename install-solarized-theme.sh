#!/bin/sh
printf "attempt to add solarized\n"
git submodule add -f git://github.com/altercation/vim-colors-solarized.git vim/.vim/bundle/vim-colors-solarized
printf "done\n"
