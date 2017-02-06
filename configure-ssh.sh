#!/bin/sh
cd ~
printf "installing ssh config"
mkdir ~/.ssh/
printf "AddKeysToAgent yes\n" >> ~/.ssh/config
printf "done\n"
