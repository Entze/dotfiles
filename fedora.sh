#!/bin/sh
printf "preconfiguring git for etckeeper\n"
rm -f $HOME/.gitconfig
git config --global user.name "Lukas Grassauer"
git config --global user.email "entze@grassauer.eu"
sudo dnf install -y etckeeper
printf "done\n-----\n"
printf "update installed packages\n"
sudo dnf update
printf "done\n-----\n"
sudo dnf config-manager -y --add-repo https://download.opensuse.org/repositories/home:Horst3180/Fedora_24/home:Horst3180.repo
printf "installing all packages in packages.list"
sudo dnf install --best $(cat $HOME/dotfiles/packages.list)
printf "done\n-----\n"
printf "changing the shell to zsh\n"
chsh -s /usr/bin/zsh
printf "done\n-----\n"
printf "restoring gitconfig"
rm -f $HOME/.gitconfig
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
printf "update icon cache\n"
gtk-update-icon-cache $HOME/.icons/Numix
gtk-update-icon-cache $HOME/.icons/Numix-Circle
printf "done\n-----\n"
ln -s ~/.config/xfce4/terminal/Darkterminalrc ~/.config/xfce4/terminal/terminalrc
printf "done with everything.\nCheck and then restart.\n"
