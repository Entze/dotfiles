#!/bin/sh
printf "preconfiguring git for etckeeper\n"
rm -f $HOME/.gitconfig
git config --global user.name "Lukas Grassauer"
git config --global user.email "entze@grassauer.eu"
sudo dnf install -y etckeeper
printf "done\n"
sudo dnf config-manager -y --add-repo http://download.opensuse.org/repositories/home:Horst3180/Fedora_24/home:Horst3180.repo
printf "installing all packages in packages.list"
sudo dnf install $(cat $HOME/dotfiles/packages.list)
printf "done\n"
printf "changing the shell to zsh\n"
chsh -s /usr/bin/zsh
printf "done\n"
printf "restoring gitconfig"
rm -f $HOME/.gitconfig
printf "done\n"
printf "stowing dotfiles"
stow --verbose=1 emacs
stow --verbose=1 git
stow --verbose=1 vim
stow --verbose=1 xfce
stow --verbose=1 zsh
printf "done\n"
$HOME/dotfiles/configure-ssh.sh
$HOME/dotfiles/install-emacs-plugins.sh
$HOME/dotfiles/install-solarized-theme.sh
$HOME/dotfiles/install-oh-my-zsh.sh
$HOME/dotfiles/install-zsh-theme.sh
printf "update icon cache\n"
gtk-update-icon-cache ~/.icons/Numix-Circle
printf "done\n"
ln -s ~/.config/xfce4/terminal/Darkterminalrc ~/.config/xfce4/terminal/terminalrc
printf "done with everything.\nCheck and then restart.\n"
