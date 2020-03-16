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

do_os(){
  case "$(uname)" in
    "Linux")
      do_linux
      ;;
    *) die "Unsupported os: $(uname)"
  esac
}

do_linux(){
  OS_ID=$(grep -E '^ID=".*"$' /etc/os-release | sed -E 's/(^ID=")(.*)("$)/\2/')
  case "$OS_ID" in
    "solus")
      set_solus
      do_common
      do_solus
      ;;
    *) die "Unsupported distribution: $OS_ID"
  esac
}

set_solus(){
  PKG_MNG="eopkg"
  INSTALL="it"
  set_packages common.packages solus.packages
}

set_packages(){
	PACKAGES=$(cat $@ | sort --unique | tr "\n" ' ' | sed -E 's/[ \t]*$//')
}


do_common(){
  trace "Creating ~/.local/bin, if not already present"
  mkdir -p "$HOME/.local/bin"

  trace "Creating ~/Apps, if not already present"
  mkdir -p "$HOME/Apps/.bin"

  PATH="$PATH:$HOME/.local/bin:$HOME/Apps/.bin:$HOME/.cargo/bin"

  if [ -z "$SKIP_PACKAGES" ]
  then
      INST=( "$PKG_MNG" "$INSTALL" $PACKAGES )
      sudocmd "to install packages" "${INST[@]}"
  fi

  do_initial_submodules

}

do_solus(){
    INST=( $PKG_MNG $INSTALL -c system.devel )
    sudocmd "install dev-tools" "${INST[@]}"
    do_gnome_terminal
    do_antibody
    do_languagetool
    do_stack
    do_stylish_haskell
    do_starship
    do_npm
    do_diff_so_fancy
}

do_starship(){
     info "Installing starship."
     cargo install starship
}

do_initial_submodules(){

  debug "Init all submodules."

  DEPTH=1
  EV=( git submodule update --quiet --depth "$DEPTH" --init --recursive )
  while ! "${EV[@]}"
  do
      DEPTH=$((DEPTH + 1))
      EV=( git submodule update --quiet --depth "$DEPTH" --init --recursive )
  done

}

do_gnome_terminal(){
    trace "Installing Nord Gnome-terminal theme"
    if [[ -x "nord-gnome-terminal/src/nord.sh" ]]
    then
	nord-gnome-terminal/src/nord.sh --loglevel "$((VERBOSITY + 2))" --profile "Nord"
    else
	die "Nord Gnome-terminal theme not downloaded or moved."
    fi
}

do_languagetool(){
  trace "Checking if languagetool is on correct path."
  if [ ! -f "$HOME/Apps/.bin/languagetool-commandline.jar" ]
  then
     trace "Checking if languagetool is installed."
     if  [ ! -f "$HOME/Apps/LanguageTool/LanguageTool-4.8/languagetool-commandline.jar" ]
     then
	 info "installing languagetool"
	 debug "downloading"
	 curl --output LanguageTool-4.8.zip -fsSL "https://languagetool.org/download/LanguageTool-4.8.zip"
	 mkdir -p "$HOME/Apps/LanguageTool"
	 debug "extracting"
	 unzip -qq -u -d "$HOME/Apps/LanguageTool" LanguageTool-4.8.zip
	 rm -f LanguageTool-4.8.zip
     fi
     trace "symlinking languagetool to the correct spot"
     ln -s "$HOME/Apps/LanguageTool/LanguageTool-4.8/languagetool-commandline.jar" "$HOME/Apps/.bin/languagetool-commandline.jar"
  fi
}

do_stack(){
    info "Getting stack up to date."
    trace "stack update"
    stack update
    trace "stack upgrade"
    stack upgrade
}

do_stylish_haskell(){
    stack install stylish-haskell
}

do_antibody(){

    info "Installing Zsh plugins."

    trace "antibody bundle"

    antibody bundle < zsh/.zsh_plugins > zsh/.zsh_plugins.txt

    trace "done."
}

do_npm(){

    mkdir "$HOME/.npm-packages"
    npm config set prefix "$HOME/.npm-packages"
    NPM_PACKAGES="${HOME}/.npm-packages"

    export PATH="$PATH:$NPM_PACKAGES/bin"
    export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

}

do_diff_so_fancy(){

    npm install -g diff-so-fancy

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
