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
stow --verbose=1 os
stow --verbose=1 with_de
stow --verbose=1 zsh
printf "done.\n-----\n"
printf "changing to zsh\n"
chsh -s /bin/zsh || chsh -s /usr/bin/zsh
printf "done.\n-----\n"
