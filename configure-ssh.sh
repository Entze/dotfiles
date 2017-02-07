#!/bin/sh
cd $HOME
printf "installing ssh config"
mkdir $HOME/.ssh/
printf "AddKeysToAgent yes\n" >> $HOME/.ssh/config
printf "done\n"
