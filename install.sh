printf "updating packages\n"
sudo $PKGMNG $PKGUPGRADE $ASSUMEYES --
printf "done.\n-----\n"
printf "install packages from packages list\n"
sudo $PKGMNG $PKGINSTALL $ASSUMEYES -- $(cat $HOME/dotfiles/packages.common.list $HOME/dotfiles/$PACKAGES)
printf "done.\n-----\n"
printf "restoring gitconfig\n"
rm -f -- $HOME/.gitconfig
cd -- $HOME/dotfiles/.
stow --verbose=1 -- git
printf "done.\n-----\n"
printf "fetching submodules\n"
git submodule update --init --recursive --remote --
printf "done.\n-----\n"
