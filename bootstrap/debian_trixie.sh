#!/usr/bin/env bash

set -x
set -e
set -u
set -o pipefail

function ensure_installed() {

  pkgs="$(mktemp --tmpdir="/tmp" 'bootstrap-debian-trixie.XXXX')"
  dpkg --list > "$pkgs"

  for pkg in "$@"; do

    set +e
    set +o pipefail
    grep --quiet --extended-regexp "ii[[:space:]]+${pkg}[[:space:]]" "$pkgs"
    installed="$?"
    set -e
    set -o pipefail

    if [[ "$installed" -eq 1 ]]; then

      sudo apt-get install --assume-yes "$pkg"

    fi

  done

}

function install_deb_get() {

  downloads="$(mktemp --tmpdir="/tmp" 'bootstrap-debian-trixie.XXXX')"

  wget --quiet --output-document - "https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get" >"${downloads}"/deb-get
  chmod +x "${downloads}"/deb-get
  sudo "${downloads}"/deb-get install deb-get

}

function install_mise() {

  deb-get install "mise"

}


function install_chezmoi() {

  mise use --global --yes "chezmoi@latest"

}

ensure_installed git gh
set +e
set +o pipefail
gh auth status
gh_auth_status="$?"
set -e
set -o pipefail
if [[ "$gh_auth_status" -eq 1 ]]; then
  gh auth login
fi
export DEBGET_TOKEN="${GITHUB_TOKEN:-$(gh auth token)}"
ensure_installed curl lsb-release wget
install_deb_get
deb-get update
install_mise
install_chezmoi
