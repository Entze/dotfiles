#!/usr/bin/env bash

set -e
set -u
set -o pipefail

function ensure_installed() {

  pkgs="$(mktemp --tmpdir="/tmp" 'bootstrap-debian-13.XXXX')"
  dpkg --list > "$pkgs"

  for pkg in "$@"; do
    grep --quiet "ii[[:space:]]+${pkg}" "$pkgs"
    if [[ "$?" -eq 1 ]]; then
      sudo apt-get install --assume-yes "$pkg"
    fi
  done

}


function install_mise() {

  dpkg --list | grep --quiet "ii[[:space:]]+mise"
  if [[ "$?" -eq 1 ]]; then

    sudo apt-get update --assume-yes
    sudo apt-get upgrade --assume-yes
    ensure_installed "gpg" "sudo" "wget" "curl"
    sudo install --directory --mode 'u=rwx,go=rx' "/etc/apt/keyrings"
    wget --quiet --output-document - "https://mise.jdx.dev/gpg-key.pub" > "mise-archive-keyring"
    gpg --dearmor "mise-archive-keyring"
    sudo mv "mise-archive-keyring.gpg" "/etc/apt/keyrings/."

    mise_sources="$(mktemp 'bootstrap-mise.XXXX')"

    printf "X-Repolib-Name: mise\nEnabled: yes\nTypes: deb\nURIs: https://mise.jdx.dev/deb\nSuites: stable\nComponents: main\nSigned-By: /etc/apt/keyrings/mise-archive-keyring.gpg\nArchitectures: amd64\n" > "$mise_sources"
    sudo mv "$mise_sources" "/etc/apt/sources.list.d/mise.sources"

    sudo apt-get update
    ensure_installed "mise"

  fi

}


function install_chezmoi() {

  mise use --global --yes "chezmoi"

}


install_mise
install_chezmoi
ensure_installed git
