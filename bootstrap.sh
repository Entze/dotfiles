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

THIS_PWD="$(pwd)"

DOWNLOADER="aria2c"
DOWNLOADER_FLAG="-o"
if ! which "$DOWNLOADER" > /dev/null 2>&1
then
  DOWNLOADER="wget2"
  DOWNLOADER_FLAG="-O"
  if ! which "$DOWNLOADER" > /dev/null 2>&1
  then
    DOWNLOADER="wget"
    DOWNLOADER_FLAG="-O"
    if ! which "$DOWNLOADER" > /dev/null 2>&1
    then
      DOWNLOADER="curl"
      DOWNLOADER_FLAG="-o"
    fi
  fi
fi


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

do_miniconda () {

  debug "Install miniconda"

  trace "Change directory to ~/Downloads"
  cd "$HOME/Downloads"

  trace "Download miniconda-installer with $DOWNLOADER"
  "$DOWNLOADER" "$DOWNLOADER_FLAG" "miniconda.sh" "https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh"

  trace "Make miniconda-installer executable"
  chmod +x miniconda.sh

  trace "Run miniconda-installer"
  ./miniconda.sh -b -p "$HOME/.miniconda3/"

}


do_ghcup() {

  debug "Install ghcup"

  export BOOTSTRAP_HASKELL_NONINTERACTIVE=1
  export BOOTSTRAP_HASKELL_NO_UPGRADE=0
  export BOOTSTRAP_HASKELL_MINIMAL=0
  export GHCUP_USE_XDG_DIRS=1
  export BOOTSTRAP_HASKELL_VERBOSE=1
  export BOOTSTRAP_HASKELL_INSTALL_STACK=1
  export BOOTSTRAP_HASKELL_INSTALL_HLS=1
  export BOOTSTRAP_HASKELL_ADJUST_BASHRC=0
  export BOOTSTRAP_HASKELL_ADJUST_CABAL_CONFIG=0

  trace "Change directory to ~/Downloads"
  cd "$HOME/Downloads"

  trace "Download ghcup-installer with $DOWNLOADER"
  "$DOWNLOADER" "$DOWNLOADER_FLAG" "ghcup.sh" "https://get-ghcup.haskell.org/"

  trace "Make ghcup-installer executable"
  chmod +x ghcup.sh

  trace "Run ghcup-installer"
  ./ghcup.sh

  trace "Make ghcup targets visible for session"
  # shellcheck disable=SC1090,SC1091
  source "$HOME/.local/share/ghcup/env"
  export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

  trace "Install ghc via ghcup"
  ghcup install ghc

  trace "Install ghc 8.10 via ghcup"
  ghcup install ghc 8.10

  trace "Install ghc 9.0 via ghcup"
  ghcup install ghc 9.0

  trace "Install ghc 9.2 via ghcup"
  ghcup install ghc 9.2

  trace "Install cabal via ghcup"
  ghcup install cabal

  trace "Install stack via ghcup"
  ghcup install stack

  stack config set install-ghc false --global
  stack config set system-ghc  true  --global

  trace "Install hls via ghcup"
  ghcup install hls

}


do_stack() {

  debug "Install stack"

  trace "Install the dependencies of stack"
  sudo apt-get install g++ gcc libc6-dev libffi-dev libgmp-dev make xz-utils zlib1g-dev git gnupg netbase

  trace "Change directory to ~/Downloads"
  cd "$HOME/Downloads"

  trace "Download stack with $DOWNLOADER"
  "$DOWNLOADER" "$DOWNLOADER_FLAG" "stack-linux-x86_64.tar.gz" "https://get.haskellstack.org/stable/linux-x86_64.tar.gz"

  trace "Extract stack"
  tar --extract --file "stack-linux-x86_64.tar.gz"

  trace "Move stack to ~/.local/bin"
  find . -type f -iname "stack" | grep -E "stack-[0-9]+\.[0-9]+\.[0-9]+-linux-x86_64" | sort | xargs -L 1 mv -t "$HOME/.local/bin/."

}


do_cod() {

  debug "Install cod"

  trace "Change directory to ~/Downloads"
  cd "$HOME/Downloads"

  trace "Download cod with $DOWNLOADER"
  "$DOWNLOADER" "$DOWNLOADER_FLAG" "cod-linux-amd64.tgz" "https://github.com/dim-an/cod/releases/latest/download/cod-linux-amd64.tgz"

  trace "Extract cod"
  tar --extract --file "cod-linux-amd64.tgz"

  trace "Move cod to ~/.local/bin"
  mv "cod" "$HOME/.local/bin/."

}


do_znap() {

  debug "Install znap"

  trace "Create ~/Apps/zsh-plugins/"
  mkdir -p "$HOME/Apps/zsh-plugins/"

  trace "Download zsh-snap via git"
  git clone --depth 1 "https://github.com/marlonrichert/zsh-snap.git" "$HOME/Apps/zsh-plugins/zsh-snap"

}


do_starship() {

  debug "Install starship"

  trace "Change directory to ~/Downloads"
  cd "$HOME/Downloads"

  trace "Download starship-installer with $DOWNLOADER"
  "$DOWNLOADER" "$DOWNLOADER_FLAG" starship.sh "https://starship.rs/install.sh"


  trace "Make starship-installer executable"
  chmod +x starship.sh

  trace "Run starship-installer"
  ./starship.sh -y -b "$HOME/.local/bin"

}


do_npm() {

  debug "Make npm not require sudo"

  trace "Create $HOME/.npm-packages"
  mkdir -p "$HOME/.npm-packages"

  trace "Configure npm"
  npm config set prefix "$HOME/.npm-packages"
  NPM_PACKAGES="${HOME}/.npm-packages"

  trace "Export variables for the remainder of this session"
  export PATH="$PATH:$NPM_PACKAGES/bin"
  export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

}

do_diff_so_fancy() {

  debug "Install diff-so-fancy"

  trace "Run npm installation for diff-so-fancy"
  npm install -g diff-so-fancy

}


do_emacs_on_linux() {

  debug "Install emacs, specifically for linux"

  trace "Change directory to ~/Downloads"
  cd "$HOME/Downloads"

  trace "Download Haskell Language Server with $DOWNLOADER"
  "$DOWNLOADER" "$DOWNLOADER_FLAG" "haskell-language-server-Linux-1.2.0.tar.gz" "https://github.com/haskell/haskell-language-server/releases/download/1.2.0/haskell-language-server-Linux-1.2.0.tar.gz"

  trace "Create $HOME/Apps/haskell-language-server"
  mkdir -p "$HOME/Apps/haskell-language-server"

  trace "Change directory to ~/Apps/haskell-language-server"
  cd "$HOME/Apps/haskell-language-server"


  if which fdfind > /dev/null 2>&1
  then
    fdfind --type file --exec ln -s "$HOME/Apps/haskell-language-server/{/}" "$HOME/.local/bin/{/}" \;
  elif which fd > /dev/null 2>&1
  then
    fd --type file --exec ln -s "$HOME/Apps/haskell-language-server/{/}" "$HOME/.local/bin/{/}" \;
  else
    find . -type f -exec ln -s "$HOME/Apps/haskell-language-server/{}" "$HOME/.local/bin/{}" \;
  fi

}


do_agda() {

  debug "Install Agda and its standard library"

  trace "Install Agda"
  cabal v2-update
  cabal v2-install alex happy
  cabal v2-install --with-compiler ghc-9.0 --lib Agda ieee754

  trace "Change directory to ~/Downloads/"
  cd "$HOME/Downloads"

  trace "Download agda-stdlib v1.7 with $DOWNLOADER"
  "$DOWNLOADER" "$DOWNLOADER_FLAG" "agda-stdlib.tar" "https://github.com/agda/agda-stdlib/archive/v1.7.tar.gz"

  trace "Extract agda-stdlib"
  tar -zxvf "agda-stdlib.tar"

  trace "Create ~/Apps/Agda/"
  mkdir -p "$HOME/Apps/Agda/"

  trace "Move agda-stdlib to ~/Apps/Agda/."
  mv "agda-stdlib-1.7" "$HOME/Apps/Agda/."

  trace "Change directory to ~/Apps/Agda/agda-stdlib-1.7"
  cd "$HOME/Apps/Agda/agda-stdlib-1.7"

  trace "Install agda-stdlib"
  cabal v2-install --with-compiler ghc-9.0

  trace "Create ~/.agda"
  mkdir -p "$HOME/.agda"

  trace "Create ~/.agda/libraries and populate file"
  printf "%s/Apps/Agda/agda-stdlib-1.7/standard-library.agda-lib" "$HOME" >> "$HOME/.agda/libraries"


}


do_post_distro() {

  info "Execute special (post) installations for programs:"

  info "(0/8) npm"
  do_npm
  info "(1/8) diff-so-fancy"
  do_diff_so_fancy
  info "(2/8) cod"
  do_cod
  info "(3/8) starship"
  do_starship
  info "(4/8) znap"
  do_znap
  info "(5/8) ghcup"
  do_ghcup
  info "(6/8) agda"
  do_agda
  info "(7/8) miniconda"
  do_miniconda

  info "(8/8) done."

}


do_ubuntu() {

  debug "Do installation steps for ubuntu"

  VERSION="$(grep -F "VERSION_ID" /etc/os-release | sed -E "s/^VERSION_ID=\"([0-9]{2})\.([0-9]{2})\"/\\1\\2/")"


  if [ "$SKIP_PACKAGES" != "true" ]
  then
  VERSIONDEPS=ubuntu."$VERSION".packages
  trace "Update archive"
  sudo apt-get update
  trace "Install packages"
  xargs -a <(awk '! /^ *(#|$)/' <(sort --unique ubuntu.packages common.packages "$VERSIONDEPS")) -r -- sudo apt-get install -y
  fi

  DOWNLOADER="aria2c"
  DOWNLOADER_FLAG="-o"
  if ! which "$DOWNLOADER" > /dev/null 2>&1
  then
    DOWNLOADER="wget2"
    DOWNLOADER_FLAG="-O"
    if ! which "$DOWNLOADER" > /dev/null 2>&1
    then
      DOWNLOADER="wget"
      DOWNLOADER_FLAG="-O"
      if ! which "$DOWNLOADER" > /dev/null 2>&1
      then
        DOWNLOADER="curl"
        DOWNLOADER_FLAG="-o"
      fi
    fi
  fi
  debug "Downloader set to $DOWNLOADER"

}

do_solus() {

  debug "Do installation steps for solus"

  sudocmd "install dev-tools" "sudo eopkg install -c system.devel"

  if [ "$SKIP_PACKAGES" != "true" ]
  then
  trace "Install packages"
  xargs -a <(awk '! /^ *(#|$)/' <(sort --unique solus.packages common.packages)) -r -- sudo eopkg install -y
  fi

  DOWNLOADER="aria2c"
  DOWNLOADER_FLAG="-o"
  if ! which "$DOWNLOADER" > /dev/null 2>&1
  then
    DOWNLOADER="wget2"
    DOWNLOADER_FLAG="-O"
    if ! which "$DOWNLOADER" > /dev/null 2>&1
    then
      DOWNLOADER="wget"
      DOWNLOADER_FLAG="-O"
      if ! which "$DOWNLOADER" > /dev/null 2>&1
      then
        DOWNLOADER="curl"
        DOWNLOADER_FLAG="-o"
      fi
    fi
  fi
  debug "Downloader set to $DOWNLOADER"

}


do_common() {

  debug "Do common installation steps"

  trace "Create ~/.local/bin/, if not already present"
  mkdir -p "$HOME/.local/bin/"

  trace "Create ~/Apps/.bin/, if not already present"
  mkdir -p "$HOME/Apps/.bin/"

  trace "Create ~/.config, if not already present"
  mkdir -p "$HOME/.config"

  trace "Create ~/.cache, if not already present"
  mkdir -p "$HOME/.cache"

  trace "Create ~/.local/share, if not already present"
  mkdir -p "$HOME/.local/share"

  trace "Create ~/.local/state, if not already present"
  mkdir -p "$HOME/.local/state"

  trace "Create ~/Downloads, if not already present"
  mkdir -p "$HOME/Downloads"

  trace "Export necessary variables like PATH for this session"
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
    debug "Install for solus"
    do_common
    do_solus
    do_post_distro
    ;;
  "ubuntu")
    debug "Install for ubuntu"
    do_common
    do_ubuntu
    do_post_distro
    ;;
  *) die "Unsupported distribution: $OS_ID"
  esac

}

do_os() {

  OS_KIND="$(uname)"
  trace "Found os: $OS_KIND"
  case "$OS_KIND" in
  "Linux")
    debug "Install for linux"
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

cd "$THIS_PWD"
