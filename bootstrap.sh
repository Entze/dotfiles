#!/bin/bash

set -euo pipefail

BOLD="$(tput bold 2>/dev/null || echo '')"
GREY="$(tput setaf 0 2>/dev/null || echo '')"
UNDERLINE="$(tput smul 2>/dev/null || echo '')"
RED="$(tput setaf 1 2>/dev/null || echo '')"
GREEN="$(tput setaf 2 2>/dev/null || echo '')"
YELLOW="$(tput setaf 3 2>/dev/null || echo '')"
BLUE="$(tput setaf 4 2>/dev/null || echo '')"
MAGENTA="$(tput setaf 5 2>/dev/null || echo '')"
NO_COLOR="$(tput sgr0 2>/dev/null || echo '')"


trace() {

  if [ "$VERBOSITY" -ge 2 ]
  then
    printf "${GREEN}?${NO_COLOR} $@\n"
  fi

}

debug() {

  if [ "$VERBOSITY" -ge 1 ]
  then
    printf "${BOLD}${GREEN}:${NO_COLOR} $@\n"
  fi

}

info() {

  if [ "$VERBOSITY" -ge 0 ]
  then
    printf ">${NO_COLOR} $@\n"
  fi

}

warn() {

  if [ "$VERBOSITY" -ge -1 ]
  then
    printf "${YELLOW}! $@${NO_COLOR}\n"
  fi

}

error() {

  if [ "$VERBOSITY" -ge -2 ]
  then
     printf "${RED}x $@${NO_COLOR}\n" >&2
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

do_starship() {

     trace "Installing starship"
     cargo install starship

}

do_antibody() {

    trace "Installing Zsh plugins"

    antibody bundle < zsh/.zsh_plugins > zsh/.zsh_plugins.sh

    trace "done."
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
  do_antibody
  do_starship
  do_npm
  do_diff_so_fancy

}

do_solus() {

  trace "Doing installation steps for solus"
  INST=( $PKG_MNG $INSTALL -c system.devel )
  sudocmd "install dev-tools" "${INST[@]}"
  do_antibody
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

  PATH="$PATH:$HOME/.local/bin:$HOME/Apps/.bin:$HOME/.cargo/bin"

  if [ -z "$SKIP_PACKAGES" ]
  then
      INST=( "$PKG_MNG" "$INSTALL" $PACKAGES )
      sudocmd "to install packages" "${INST[@]}"
  fi

}

set_packages() {

  PACKAGES=$(sort --unique $@ | tr "\n" ' ' | sed -E 's/[ \t]*$//')

}

set_ubuntu() {

  trace "Setting variables for ubuntu"
  PKG_MNG="apt-get"
  INSTALL="install"
  set_packages common.packages ubuntu.packages

}

set_solus() {

  trace "Setting variables for solus"
  PKG_MNG="eopkg"
  INSTALL="it"
  set_packages common.packages solus.packages

}

do_linux() {

  OS_ID=$(grep -E '^ID="?[a-zA-Z]*"?$' /etc/os-release | sed -E 's/(^ID="?)([a-zA-Z]*)("?$)/\2/')
  trace "Found linux: $OS_ID"
  case "$OS_ID" in
    "solus")
      debug "Installing for solus"
      set_solus
      do_common
      do_solus
      ;;
    "ubuntu")
      debug "Installing for ubuntu"
      set_ubuntu
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
    -p|--platform) ARG_PLATFORM="$2"; shift 2;;

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
