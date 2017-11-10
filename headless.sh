printf "stowing dotfiles\n"
cd $HOME/dotfiles/.
stow --verbose=1 os
printf "done.\n-----\n"
