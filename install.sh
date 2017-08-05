printf "updating packages\n"
sudo $PKGMNG $PKGUPGRADE $ASSUMEYES
printf "done.\n-----\n"
printf "install packages from packages list\n"
sudo $PKGMNG $PKGINSTALL $ASSUMEYES $(cat $HOME/dotfiles/packages.list)
printf "done.\n-----\n"
printf "restoring gitconfig\n"
rm -f $HOME/.gitconfig
cd $HOME/dotfiles/.
stow --verbose=1 git
printf "done.\n-----\n"
printf "configuring programs\n"
$HOME/dotfiles/configure-ssh.sh
$HOME/dotfiles/install-emacs-plugins.sh
$HOME/dotfiles/install-oh-my-zsh.sh
$HOME/dotfiles/install-zsh-theme.sh
printf "done.\n-----\n"
printf "stowing dotfiles\n"
cd $HOME/dotfiles/.
stow --verbose=1 emacs
stow --verbose=1 vim
stow --verbose=1 xfce
stow --verbose=1 zsh
printf "done.\n-----\n"
printf "changing to zsh"
chsh -s /usr/bin/zsh
printf "done.\n-----\n"
printf "updating packages\n"
sudo $PKGMNG $PKGUPGRADE $ASSUMEYES
printf "done.\n-----\n"
