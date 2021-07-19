#!/bin/bash

set -euo pipefail

BOLD="$(tput bold 2>/dev/null || echo '')"
#GREY="$(tput setaf 0 2>/dev/null || echo '')"
#UNDERLINE="$(tput smul 2>/dev/null || echo '')"
RED="$(tput setaf 1 2>/dev/null || echo '')"
GREEN="$(tput setaf 2 2>/dev/null || echo '')"
YELLOW="$(tput setaf 3 2>/dev/null || echo '')"
#BLUE="$(tput setaf 4 2>/dev/null || echo '')"
#MAGENTA="$(tput setaf 5 2>/dev/null || echo '')"
NO_COLOR="$(tput sgr0 2>/dev/null || echo '')"


trace() {

  if [ "$VERBOSITY" -ge 2 ]
  then
    printf "%b?%b %s\n" "${GREEN}" "${NO_COLOR}" "$@"
  fi

}

debug() {

  if [ "$VERBOSITY" -ge 1 ]
  then
    printf "%b:%b %s\n" "${BOLD}${GREEN}" "${NO_COLOR}" "$@"
  fi

}

info() {

  if [ "$VERBOSITY" -ge 0 ]
  then
    printf ">%b %s\n" "${NO_COLOR}" "$@"
  fi

}

warn() {

  if [ "$VERBOSITY" -ge -1 ]
  then
    printf "%b! %s%b\n" "${YELLOW}" "$@" "${NO_COLOR}"
  fi

}

error() {

  if [ "$VERBOSITY" -ge -2 ]
  then
    printf "%bx %s%b\n" "${RED}" "$@" "${NO_COLOR}" >&2
  fi

}

sudocmd() {

  reason="$1"; shift
  if command -v sudo >/dev/null; then
    printf "\nAbout to use 'sudo' to run the following command as root:
      "
    printf "%s " "$@"
    printf "\n in order to %s.\n\n" "$reason"
    # -k: Disable cached credentials (force prompt for password).
    sudo -k "$@"
  else
    "$@"
  fi

}

# print a message to stderr and exit with error code
die() {

  error "$@"
  exit 1

}

do_cod() {
  trace "Downloading the latest cod"

  downloader="aria2c"
  if ! which -p "$downloader" > /dev/null 2>&1
  then
    downloader=wget
    if ! which -p "$downloader" > /dev/null 2>&1
    then
      downloader="curl"
    fi
  fi

  cd Downloads

  "$downloader" "https://github.com/dim-an/cod/releases/latest/download/cod-linux-amd64.tgz"

  tar --extract --file cod-linux-amd64.tgz

  mv cod "$HOME"/.local/bin/.

}

do_znap() {

  trace "Creating ~/Apps/zsh-plugins/, if not already present"
  mkdir -p "$HOME/Apps/zsh-plugins/"

  trace "Installing zsh-snap"
  git clone --depth 1 "https://github.com/marlonrichert/zsh-snap.git" "$HOME/Apps/zsh-plugins/zsh-snap"

}

do_starship() {

  trace "Installing starship"
  cargo install starship

}

do_npm() {

  trace "Make npm not require sudo"

  trace "Creating $HOME/.npm-packages, if it does not exist"
  mkdir -p "$HOME/.npm-packages"

  npm config set prefix "$HOME/.npm-packages"
  NPM_PACKAGES="${HOME}/.npm-packages"

  export PATH="$PATH:$NPM_PACKAGES/bin"
  export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

}

do_diff_so_fancy() {

  trace "Installing diff-so-fancy"
  npm install -g diff-so-fancy

}

do_ubuntu() {
  
  trace "Doing installation steps for ubuntu"

  if [ "$SKIP_PACKAGES" != "true" ]
  then
    xargs -a <(awk '! /^ *(#|$)/' <(sort --unique ubuntu.packages common.packages)) -r -- sudo apt-get install -y
  fi

  do_znap
  do_starship
  do_npm
  do_diff_so_fancy

}

do_solus() {

  trace "Doing installation steps for solus"

  sudocmd "install dev-tools" "sudo eopkg install -c system.devel"

  if [ "$SKIP_PACKAGES" != "true" ]
  then
    xargs -a <(awk '! /^ *(#|$)/' <(sort --unique solus.packages common.packages)) -r -- sudo eopkg install -y
  fi

  do_znap
  do_starship
  do_npm
  do_diff_so_fancy

}


do_common() {

  trace "Doing common installation steps"
  trace "Creating ~/.local/bin/, if not already present"
  mkdir -p "$HOME/.local/bin/"

  trace "Creating ~/Apps/.bin/, if not already present"
  mkdir -p "$HOME/Apps/.bin/"

  trace "Creating ~/.config, if not already present"
  mkdir -p "$HOME/.config"

  trace "Creating ~/.cache, if not already present"
  mkdir -p "$HOME/.cache"

  trace "Creating ~/.local/share, if not already present"
  mkdir -p "$HOME/.local/share"

  trace "Creating ~/.local/state, if not already present"
  mkdir -p "$HOME/.local/state"

  export PATH="$PATH:$HOME/.local/bin:$HOME/Apps/.bin:$HOME/.cargo/bin"

  export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
  export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

}

do_linux() {

  OS_ID=$(grep -E '^ID="?[a-zA-Z]*"?$' /etc/os-release | sed -E 's/(^ID="?)([a-zA-Z]*)("?$)/\2/')
  trace "Found linux: $OS_ID"
  case "$OS_ID" in
    "solus")
      debug "Installing for solus"
      do_common
      do_solus
      ;;
    "ubuntu")
      debug "Installing for ubuntu"
      do_common
      do_ubuntu
      ;;
    *) die "Unsupported distribution: $OS_ID"
  esac

}

do_os() {

  OS_KIND="$(uname)"
  trace "Found os: $OS_KIND"
  case "$OS_KIND" in
    "Linux")
      debug "Installing for linux"
      do_linux
      ;;
    *) die "Unsupported os: $OS_KIND"
  esac

}

VERBOSITY=0
SKIP_PACKAGES=""

# parse argv variables
while [ "$#" -gt 0 ]; do
  case "$1" in

    -v|--verbose) VERBOSITY=$((VERBOSITY + 1)); shift 1;;
    -q|--quiet) VERBOSITY=$((VERBOSITY - 1)); shift 1;;
    -s|--skip-packages) SKIP_PACKAGES="true"; shift 1;;

    -v=*|--verbose=*) VERBOSITY="${1#*=}"; shift 1;;
    -q=*|--quiet=*) VERBOSITY="${1#*=}"; shift 1;;

    *) die "Unknown option $1";
  esac
done
trace "Parsed argv variables"

do_os

debug "Done"
