#!/bin/sh
printf "preconfiguring git for etckeeper\n"
rm -f $HOME/.gitconfig
git config --global user.name "Lukas Grassauer"
git config --global user.email "entze@grassauer.eu"
sudo dnf install -y etckeeper
printf "done\n-----\n"
printf "update installed packages\n"
sudo dnf update -y
printf "done\n-----\n"
printf "installing all packages in packages.list\n"
sudo dnf install -y --best $(cat $HOME/dotfiles/packages.list)
printf "done\n-----\n"
printf "changing the shell to zsh\n"
chsh -s /usr/bin/zsh
printf "done\n-----\n"
printf "restoring gitconfig"
rm -f $HOME/.gitconfig
cd $HOME/dotfiles/.
stow --verbose=1 git
printf "done\n-----\n"
$HOME/dotfiles/configure-ssh.sh
$HOME/dotfiles/install-emacs-plugins.sh
$HOME/dotfiles/install-solarized-theme.sh
$HOME/dotfiles/install-oh-my-zsh.sh
$HOME/dotfiles/install-zsh-theme.sh
printf "stowing dotfiles"
cd $HOME/dotfiles/.
stow --verbose=1 emacs
stow --verbose=1 vim
stow --verbose=1 xfce
stow --verbose=1 zsh
printf "done\n-----\n"
ln -s ~/.config/xfce4/terminal/Darkterminalrc ~/.config/xfce4/terminal/terminalrc
printf "done with everything.\nCheck and then restart.\n"
