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
VERBOSITY=0
SKIP_PACKAGES=0

# parse argv variables
while [ "$#" -gt 0 ]; do
  case "$1" in

  -v | --verbose)
    VERBOSITY=$((VERBOSITY + 1))
    shift 1
    ;;
  -q | --quiet)
    VERBOSITY=$((VERBOSITY - 1))
    shift 1
    ;;
  -s | --skip-packages)
    SKIP_PACKAGES=1
    shift 1
    ;;
  --no-agda)
    SKIP_AGDA=1
    shift 1
    ;;
  --agda)
    SKIP_AGDA=0
    shift 1
    ;;
  --no-conda)
    SKIP_MINICONDA=1
    shift 1
    ;;
  --conda)
    SKIP_MINICONDA=0
    shift 1
    ;;
  --no-ghcup)
    SKIP_GHCUP=1
    shift 1
    ;;
  --ghcup)
    SKIP_GHCUP=0
    shift 1
    ;;
  --no-mamba)
    SKIP_MINIMAMBA=1
    shift 1
    ;;
  --mamba)
    SKIP_MINIMAMBA=0
    shift 1
    ;;
  --no-nvm)
    SKIP_NVM=1
    shift 1
    ;;
  --nvm)
    SKIP_NVM=0
    shift 1
    ;;
  --no-sdkman)
    SKIP_SDKMAN=1
    shift 1
    ;;
  --sdkman)
    SKIP_SDKMAN=0
    shift 1
    ;;
  --no-zinit)
    SKIP_ZINIT=1
    shift 1
    ;;
  --zinit)
    SKIP_ZINIT=0
    shift 1
    ;;
  --nothing)
    SKIP_AGDA=1
    SKIP_GHCUP=1
    SKIP_MINICONDA=1
    SKIP_MINIMAMBA=1
    SKIP_NVM=1
    SKIP_SDKMAN=1
    SKIP_ZINIT=1
    shift 1
    ;;
  --all)
    SKIP_AGDA=0
    SKIP_GHCUP=0
    SKIP_MINICONDA=0
    SKIP_MINIMAMBA=0
    SKIP_NVM=0
    SKIP_SDKMAN=0
    SKIP_ZINIT=0
    shift 1
    ;;

  -v=* | --verbose=*)
    VERBOSITY="${1#*=}"
    shift 1
    ;;
  -q=* | --quiet=*)
    VERBOSITY="${1#*=}"
    shift 1
    ;;

  *) die "Unknown option $1" ;;
  esac
done

trace() {

  if [ "$VERBOSITY" -ge 2 ]; then
    printf "%b?%b %s\n" "${GREEN}" "${NO_COLOR}" "$@"
  fi

}

trace "Parsed argv variables"

debug() {

  if [ "$VERBOSITY" -ge 1 ]; then
    printf "%b:%b %s\n" "${BOLD}${GREEN}" "${NO_COLOR}" "$@"
  fi

}

info() {

  if [ "$VERBOSITY" -ge 0 ]; then
    printf ">%b %s\n" "${NO_COLOR}" "$@"
  fi

}

warn() {

  if [ "$VERBOSITY" -ge -1 ]; then
    printf "%b! %s%b\n" "${YELLOW}" "$@" "${NO_COLOR}"
  fi

}

error() {

  if [ "$VERBOSITY" -ge -2 ]; then
    printf "%bx %s%b\n" "${RED}" "$@" "${NO_COLOR}" >&2
  fi

}

sudocmd() {

  reason="$1"
  shift
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

trace "Loaded log functions"

check_installed() {

  CMD="$1"

  trace "Checking if $CMD is already installed"
  IS_INSTALLED=1

  if CMDPATH="$(type -P "$CMD")"; then
    IS_INSTALLED=0
    info "Found $CMD in $CMDPATH, skipping install"
  elif FUNC="$(command -v "$CMD")"; then
    IS_INSTALLED=0
    info "Found $CMD as $FUNC, skipping install"
  fi
  return "$IS_INSTALLED"

}

download() {

  OUTPUT_NAME="$1"

  LINK="$2"

  HASH_TYPE="$3"

  HASH="$4"

  trace "Change directory to ~/Downloads"
  cd "$HOME/Downloads"

  while [ ! -f "$OUTPUT_NAME" ] || ! check_hash "$OUTPUT_NAME" "$HASH_TYPE" "$HASH"; do
    trace "Removing $OUTPUT_NAME, if it exists"
    rm -f "$OUTPUT_NAME"

    trace "Download $OUTPUT_NAME with $DOWNLOADER"
    "$DOWNLOADER" "$DOWNLOADER_FLAG" "$OUTPUT_NAME" "$LINK"

  done

}

check_hash() {

  FILE="$1"
  HASH_TYPE="$2"
  HASH="$3"

  trace "Checking if $FILE matches its $HASH_TYPE hash $HASH"

  if [ "$HASH_TYPE" == "SHA1" ]; then
    printf "%s\t%s\n" "$HASH" "$FILE" | sha1sum -c
  elif [ "$HASH_TYPE" == "SHA256" ]; then
    printf "%s\t%s" "$HASH" "$FILE" | sha256sum -c
  elif [ "$HASH_TYPE" == "MD5" ]; then
    printf "%s\t%s" "$HASH" "$FILE" | md5sum -c
  elif [ "$HASH_TYPE" == "NONE" ]; then
    return 0
  else
    warn "$HASH_TYPE not supported"
    die
  fi

  return "$?"
}

trace "Loaded download helpers"

do_agda() {

  if [ "$SKIP_AGDA" -eq 1 ]; then
    return 0
  fi

  debug "Install Agda and its standard library"

  trace "Install Agda"
  cabal v2-update
  cabal v2-install alex happy
  cabal v2-install --with-compiler ghc-9.0 --lib Agda ieee754

  download "agda-stdlib.tar" "https://github.com/agda/agda-stdlib/archive/v1.7.tar.gz" "NONE" ""

  trace "Extract agda-stdlib"
  tar -zxvf "agda-stdlib.tar"

  trace "Create $AGDA_STDLIB_ROOT"
  mkdir -p "$AGDA_STDLIB_ROOT"

  trace "Move agda-stdlib to $AGDA_STDLIB_ROOT"
  mv "agda-stdlib-1.7" "$AGDA_STDLIB_ROOT/."

  trace "Change directory to $AGDA_STDLIB_ROOT/agda-stdlib-1.7"
  cd "$AGDA_STDLIB_ROOT/agda-stdlib-1.7"

  trace "Install agda-stdlib"
  cabal v2-install --with-compiler ghc-9.0

  trace "Create ~/.agda"
  mkdir -p "$HOME/.agda"

  trace "Create ~/.agda/libraries and populate file"
  printf "%s/agda-stdlib-1.7/standard-library.agda-lib" "$AGDA_STDLIB_ROOT" >>"$HOME/.agda/libraries"

}

do_ghcup() {


  if [ "$SKIP_GHCUP" -eq 1 ]; then
    return 0
  fi

  debug "Install ghcup"

  export BOOTSTRAP_HASKELL_NONINTERACTIVE=1
  export BOOTSTRAP_HASKELL_NO_UPGRADE=0
  export BOOTSTRAP_HASKELL_MINIMAL=1
  export GHCUP_USE_XDG_DIRS=1
  export BOOTSTRAP_HASKELL_VERBOSE=1
  export BOOTSTRAP_HASKELL_INSTALL_STACK=0
  export BOOTSTRAP_HASKELL_INSTALL_HLS=0
  export BOOTSTRAP_HASKELL_ADJUST_BASHRC=0
  export BOOTSTRAP_HASKELL_ADJUST_CABAL_CONFIG=0

  download "ghcup.sh" "https://get-ghcup.haskell.org" "NONE" ""

  trace "Make ghcup-installer executable"
  chmod u+x ghcup.sh

  trace "Run ghcup-installer"
  ./ghcup.sh

  ghcup upgrade

  trace "Install ghc via ghcup"
  ghcup install ghc

  trace "Install cabal via ghcup"
  ghcup install cabal

  trace "Install stack via ghcup"
  ghcup install stack

  stack config set install-ghc false --global
  stack config set system-ghc true --global

  trace "Install hls via ghcup"
  ghcup install hls

}

do_julia() {

  if [ "$SKIP_JULIA" -eq 1 ]; then
    return 0
  fi

  download "julia.tar.gz" "https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.5-linux-x86_64.tar.gz" "SHA256" "e71a24816e8fe9d5f4807664cbbb42738f5aa9fe05397d35c81d4c5d649b9d05"

  trace "Extract julia.tar.gz"
  tar -zxvf "julia.tar.gz"

  trace "Create $JULIA_ROOT, if not already present"
  mkdir -p "$JULIA_ROOT"

  trace "Move julia to $JULIA_ROOT"
  mv "julia-1.8.5/" "$JULIA_ROOT/."

  trace "Installing julia binary via symlink"
  ln -s "$JULIA_DIR/bin/julia" "$XDG_BIN_HOME/julia"

}

do_miniconda() {

  if [ "$SKIP_MINICONDA" -eq 1 ]; then
    return 0
  fi

  debug "Install Miniconda"

  download "miniconda.sh" "https://repo.anaconda.com/miniconda/Miniconda3-py310_22.11.1-1-Linux-x86_64.sh" "SHA256" "00938c3534750a0e4069499baf8f4e6dc1c2e471c86a59caa0dd03f4a9269db6"

  trace "Make miniconda-installer executable"
  chmod u+x miniconda.sh

  trace "Run miniconda-installer"
  ./miniconda.sh -b -p "$MINICONDA_DIR"

}

do_minimamba() {

  if [ "$SKIP_MINIMAMBA" -eq 1 ]; then
    return 0
  fi

  debug "Install Minimamba"

  download "minimamba.sh" "https://github.com/conda-forge/miniforge/releases/download/22.9.0-3/Mambaforge-22.9.0-3-Linux-x86_64.sh" "SHA256" "29f6374464307732c2c9d6711cdbca4d685c632f31e8bf1a5565276c65e0069b"

  trace "Make minimamba-installer executable"
  chmod u+x minimamba.sh

  trace "Run minimamba-installer"
  ./minimamba.sh -b -p "$MINICONDA_DIR"

}

do_nvm() {

  if [ "$SKIP_NVM" -eq 1 ]; then

    return 0

  fi

  debug "Install NVM"

  trace "Create $NVM_ROOT, if not already present"
  mkdir -p "$NVM_ROOT"

  trace "Clone nvm into $NVM_DIR"
  git clone --branch master --single-branch "https://github.com/nvm-sh/nvm.git" "$NVM_DIR"

  trace "Change directory to $NVM_DIR"
  cd "$NVM_DIR"

  trace "Determine latest version of nvm"
  NVM_LATEST="$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")"

  trace "Checkout version $NVM_LATEST"
  git checkout "$NVM_LATEST"

  trace "Change directory to ~"
  cd "$HOME"

  if [[ -x "$NVM_DIR/nvm.sh" ]]; then

    trace "Make nvm.sh executable"
    chmod +x "$NVM_DIR/nvm.sh"

  fi

  if [[ -x "$NVM_DIR/bash_completion" ]]; then

    chmod +x "$NVM_DIR/bash_completion"

  fi

  trace "Activate nvm"
  # shellcheck source=/dev/null
  . "$NVM_DIR/nvm.sh"

  trace "Install lastest node and npm"

  nvm install node

  nvm install --latest-npm

}


do_zinit() {

  debug "Install zinit"

  if [ "$SKIP_ZINIT" -eq 1 ]; then
    return 0
  fi

  trace "Create $ZINIT_ROOT, if not already present"
  mkdir -p "$ZINIT_ROOT"

  trace "Clone zinit into $ZINIT_HOME"
  git clone --branch main --single-branch https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

}

do_post_distro() {

  DOWNLOADER="${DOWNLOADER:-aria2c}"
  DOWNLOADER_FLAG="${DOWNLOADER_FLAG:--o}"

  if ! which "$DOWNLOADER" >/dev/null 2>&1; then
    DOWNLOADER="wget2"
    DOWNLOADER_FLAG="-O"
  fi
  if ! which "$DOWNLOADER" >/dev/null 2>&1; then
    DOWNLOADER="wget"
    DOWNLOADER_FLAG="-O"
  fi
  if ! which "$DOWNLOADER" >/dev/null 2>&1; then
    DOWNLOADER="curl"
    DOWNLOADER_FLAG="-o"
  fi
  debug "Downloader set to $DOWNLOADER"

  info "Determine what to install"

  SKIP_AGDA_DEFAULT=1
  if check_installed agda; then
    SKIP_AGDA_DEFAULT=1
  fi

  SKIP_AGDA="${SKIP_AGDA:-${SKIP_AGDA_DEFAULT}}"

  SKIP_GHCUP_DEFAULT=0
  if check_installed ghcup; then
    SKIP_GHCUP_DEFAULT=1
  fi
  SKIP_GHCUP="${SKIP_GHCUP:-${SKIP_GHCUP_DEFAULT}}"

  SKIP_JULIA_DEFAULT=0
  if check_installed julia; then
    SKIP_JULIA_DEFAULT=1
  fi
  SKIP_JULIA="${SKIP_JULIA:-${SKIP_JULIA_DEFAULT}}"

  SKIP_MINICONDA_DEFAULT=1
  if check_installed conda; then
    SKIP_MINICONDA_DEFAULT=1
  elif [[ -d "$MINICONDA_DIR" ]]; then
    info "Found miniconda in $MINICONDA_DIR, skipping install"
    SKIP_MINICONDA_DEFAULT=1
  fi
  SKIP_MINICONDA="${SKIP_MINICONDA:-${SKIP_MINICONDA_DEFAULT}}"

  SKIP_MINIMAMBA_DEFAULT=0
  if check_installed mamba; then
    SKIP_MINIMAMBA_DEFAULT=1
  elif [[ -d "$MINICONDA_DIR" ]]; then
    info "Found miniconda in $MINICONDA_DIR, skipping install"
    SKIP_MINIMAMBA_DEFAULT=1
  fi
  SKIP_MINIMAMBA="${SKIP_MINIMAMBA:-${SKIP_MINIMAMBA_DEFAULT}}"

  SKIP_NVM_DEFAULT=0
  if check_installed nvm; then
    SKIP_NVM_DEFAULT=1
  elif [[ -d "$NVM_DIR" ]]; then
    info "Found nvm in $NVM_DIR, skipping install"
    SKIP_NVM_DEFAULT=1
  fi
  SKIP_NVM="${SKIP_NVM:-${SKIP_NVM_DEFAULT}}"

  SKIP_SDKMAN_DEFAULT=0
  if check_installed sdkman; then
    SKIP_SDKMAN_DEFAULT=1
  elif [[ -d "$SDKMAN_DIR" ]]; then
    info "Found sdkman in $SDKMAN_DIR, skipping install"
    SKIP_SDKMAN_DEFAULT=1
  fi

  SKIP_ZINIT_DEFAULT=0
  if check_installed zinit; then
    SKIP_ZINIT_DEFAULT=1
  fi
  SKIP_ZINIT="${SKIP_ZINIT:-${SKIP_ZINIT_DEFAULT}}"

  info "Execute special (post) installations for programs:"

  info "(0/7) zinit"
  do_zinit
  info "(1/7) sdkman"
  do_sdkman
  info "(2/7) nvm"
  do_nvm
  if [ "$SKIP_MINICONDA" -eq 0 ]; then
    info "(3/7) miniconda"
    do_miniconda
  elif [ "$SKIP_MINIMAMBA" -eq 0 ]; then
    info "(3/7) minimamba"
    do_minimamba
  fi
  info "(4/7) julia"
  do_julia
  info "(5/7) ghcup"
  do_ghcup
  info "(6/7) agda"
  do_agda

  info "(7/7) done."

}

do_fedora() {

  debug "Do installation steps for fedora"

  if [ "$SKIP_PACKAGES" -eq 0 ]; then
    trace "Install packages"
    xargs -a <(awk '! /^ *(#|$)/' <(sort --unique fedora.packages common.packages)) -r -- sudo dnf install -y
  fi

}

do_ubuntu() {

  debug "Do installation steps for ubuntu"

  VERSION="$(grep -F "VERSION_ID" /etc/os-release | sed -E "s/^VERSION_ID=\"([0-9]{2})\.([0-9]{2})\"/\\1\\2/")"

  if [ "$SKIP_PACKAGES" -eq 0 ]; then
    VERSIONDEPS=ubuntu."$VERSION".packages
    trace "Update archive"
    sudo apt-get update
    trace "Install packages"
    xargs -a <(awk '! /^ *(#|$)/' <(sort --unique ubuntu.packages common.packages "$VERSIONDEPS")) -r -- sudo apt-get install -y
  fi

}

do_solus() {

  debug "Do installation steps for solus"

  sudocmd "install dev-tools" "sudo eopkg install -c system.devel"

  if "$SKIP_PACKAGES"; then
    trace "Install packages"
    xargs -a <(awk '! /^ *(#|$)/' <(sort --unique solus.packages common.packages)) -r -- sudo eopkg install -y
  fi

}

do_common() {

  debug "Do common installation steps"

  trace "Create ~/.local/bin/, if not already present"
  mkdir -p "$HOME/.local/bin/"

  trace "Create ~/.config, if not already present"
  mkdir -p "$HOME/.config"

  trace "Create ~/.cache, if not already present"
  mkdir -p "$HOME/.cache"

  trace "Create ~/.local/share, if not already present"
  mkdir -p "$HOME/.local/share"

  trace "Create ~/.local/state, if not already present"
  mkdir -p "$HOME/.local/state"

  trace "Create ~/.local/opt, if not already present"
  mkdir -p "$HOME/.local/opt"

  trace "Create ~/Downloads, if not already present"
  mkdir -p "$HOME/Downloads"

  trace "Export necessary variables like PATH for this session"
  export XDG_BIN_HOME="${XDG_BIN_HOME:-${HOME}/.local/bin}"
  export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
  export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
  export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
  export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
  export INSTALL_DIR="${INSTALL_DIR:-${HOME}/.local/opt}"
  export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin:$XDG_BIN_HOME:$PATH"

  export AGDA_STDLIB_ROOT="${AGDA_STDLIB_ROOT:-${INSTALL_DIR}/agda}"
  export AGDA_STDLIB_DIR="${AGDA_STDLIB_DIR:-${AGDA_STDLIB_ROOT}/agda-stlib-1.7}"
  export GHCUP_ROOT="${GHCUP_ROOT:-${HOME}/.ghcup}"
  export GHCUP_DIR="${GHCUP_DIR:-${GHCUP_ROOT}}"
  export JULIA_ROOT="${JULIA_ROOT:-${INSTALL_DIR}/julia}"
  export JULIA_DIR="${JULIA_DIR:-${JULIA_ROOT}/julia-1.7.1}"
  export MINICONDA_ROOT="${MINICONDA_ROOT:-${INSTALL_DIR}/miniconda}"
  export MINICONDA_DIR="${MINICONDA_DIR:-${MINICONDA_ROOT}}"
  export NVM_ROOT="${NVM_ROOT:-${INSTALL_DIR}/nvm}"
  export NVM_DIR="${NVM_DIR:-${NVM_ROOT}/nvm.git}"
  export SDKMAN_ROOT="${SDKMAN_ROOT:-${INSTALL_DIR}/sdkman}"
  export SDKMAN_DIR="${SDKMAN_DIR:-${SDKMAN_ROOT}}"
  export ZINIT_ROOT="${ZINIT_ROOT:-${INSTALL_DIR}/zinit}"
  export ZINIT_HOME_DIR="${ZINIT_HOME_DIR:-${ZINIT_ROOT}}"
  export ZINIT_DIR="${ZINIT_DIR:-${ZINIT_ROOT}/zinit.git}"
  export ZINIT_HOME="${ZINIT_HOME:-${ZINIT_DIR}}"

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
  "fedora")
    debug "Install for fedora"
    do_common
    do_fedora
    do_post_distro
    ;;
  *) die "Unsupported distribution: $OS_ID" ;;
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
  *) die "Unsupported os: $OS_KIND" ;;
  esac

}

trace "Loaded script"

do_os

debug "Done"

cd "$THIS_PWD"
