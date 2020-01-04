#!/bin/bash

if ! [ -s packages ]
then
	printf "No packages to install.\n"
	exit 0
else
	printf "Installing necessary packages.\n"
fi

SUDO=""

if [ whoami != "root" ]
then
	SUDO="sudo"
fi

OS_PRETTY_NAME=$(grep -E '^PRETTY_NAME=".*"$' /etc/os-release | sed -E 's/(^PRETTY_NAME=")(.*)("$)/\2/')
OS_ID=$(grep -E '^ID=".*"$' /etc/os-release | sed -E 's/(^ID=")(.*)("$)/\2/')

printf "Detected $OS_PRETTY_NAME\n"

PKG_MNG=""
INSTALL=""

if [ "$OS_ID" = "solus" ]
then
	PKG_MNG="eopkg"
	INSTALL="it"
elif [ "$OS_ID" = "fedora" ]
then
	PKG_MNG="dnf"
	INSTALL="install"
elif [ "$OS_ID" = "ubuntu" ] || [ "$OS_ID" = "debian" ]
then
	PKG_MNG="apt-get"
	INSTALL="install"
else
	printf "Could not detect a package manager\n"
	exit 1
fi

PACKAGES=$(tr "\n" ' ' < packages | sed -E 's/[ \t]*$//')

printf "$SUDO $PKG_MNG $INSTALL $PACKAGES\n"

"$SUDO" "$PKG_MNG" "$INSTALL" $PACKAGES

if ! which starship > /dev/null 2> /dev/null
then
	curl -fsSL https://starship.rs/install.sh | sudo bash
fi

