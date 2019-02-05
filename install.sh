printf "restoring gitconfig\n"
rm -f -- $HOME/.gitconfig
cd -- $HOME/dotfiles/.
stow --verbose=1 -- git
printf "done.\n-----\n"
printf "fetching submodules\n"
git submodule update --init --recursive --remote --
git submodule foreach --recursive 'git checkout master'
git submodule foreach --recursive 'git fresh'
printf "done.\n-----\n"


