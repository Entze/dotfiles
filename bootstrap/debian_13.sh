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
    ensure_installed gpg sudo wget curl
    sudo install -dm 755 /etc/apt/keyrings
    wget -qO - "https://mise.jdx.dev/gpg-key.pub" | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg

    printf "X-Repolib-Name: mise
Enabled: yes
Types: deb
URIs: https://mise.jdx.dev/deb
Suites: stable
Components: main
Signed-By: /etc/apt/keyrings/mise-archive-keyring.gpg
Architectures: amd64
" | sudo tee /etc/apt/sources.list.d/mise.sources

    sudo apt-get update
    ensure_installed mise

  fi

}


function install_chezmoi() {

  mise use --global --yes "chezmoi"

}


install_mise
install_chezmoi
ensure_installed git
export GITHUB_USER="Entze"
