# shellcheck shell=bash

# Preferred editor for local and remote sessions
if whence -p vim > /dev/null 2>&1
then
  export VISUAL="vim"
else
  export VISUAL="vi"
fi
export EDITOR="$VISUAL"
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-${HOME}/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-${HOME}/.local/state}


# pip
export PIP_REQUIRE_VIRTUALENV=1

# ghcup
export GHCUP_USE_XDG_DIRS=1

export AGDA_STDLIB_ROOT="${AGDA_STDLIB_ROOT:-${XDG_DATA_HOME}/agda}"
export AGDA_STDLIB_DIR="${AGDA_STDLIB_DIR:-${AGDA_STDLIB_ROOT}/agda-stlib}"
export NVM_ROOT="${NVM_ROOT:-${XDG_DATA_HOME}/nvm}"
export NVM_DIR="${NVM_DIR:-${NVM_ROOT}/nvm.git}"
export PYENV_ROOT="${PYENV_ROOT:-${XDG_DATA_HOME}/pyenv}"
export PYENV_DIR="${PYENV_DIR:-${PYENV_ROOT}/pyenv.git}"
export ZINIT_ROOT="${ZINIT_ROOT:-${XDG_DATA_HOME}/zinit}"
export ZINIT_HOME_DIR="${ZINIT_HOME_DIR:-${ZINIT_ROOT}}"
export ZINIT_DIR="${ZINIT_DIR:-${ZINIT_ROOT}/zinit.git}"
export ZINIT_HOME="${ZINIT_HOME:-${ZINIT_DIR}}"

# github
if [[ -r "$HOME"/.github/ENV ]]
then
   # shellcheck disable=SC1090
   source "$HOME"/.github/ENV
fi

if [[ -r "$XDG_CONFIG_HOME"/.github/ENV ]]
then
   # shellcheck disable=SC1090
   source "$XDG_CONFIG_HOME"/.github/ENV
fi

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# ssh
if [[ -r "$XDG_CONFIG_HOME"/.ssh/id_ecdsa ]]
then
    export SSH_KEY_PATH="$XDG_CONFIG_HOME"/.ssh/id_ecdsa
fi
if [[ -r "$XDG_CONFIG_HOME"/.ssh/id_ed25519 ]]
then
    export SSH_KEY_PATH="$XDG_CONFIG_HOME"/.ssh/id_ed25519
fi
if [[ -r "$XDG_CONFIG_HOME"/.ssh/id_rsa ]]
then
   export SSH_KEY_PATH="$XDG_CONFIG_HOME"/.ssh/id_rsa
fi

if [[ -r "$HOME"/.ssh/id_ecdsa ]]
then
   export SSH_KEY_PATH="$HOME"/.ssh/id_ecdsa
fi
if [[ -r "$HOME"/.ssh/id_ed25519 ]]
then
   export SSH_KEY_PATH="$HOME"/.ssh/id_ed25519
fi
if [[ -r "$HOME"/.ssh/id_rsa ]]
then
   export SSH_KEY_PATH="$HOME"/.ssh/id_rsa
fi

export OS_ID=$(grep -E '^ID="?[a-zA-Z]*"?$' /etc/os-release | sed -E 's/(^ID="?)([a-zA-Z]*)("?$)/\2/')

if [[ $OS_ID = "ubuntu" ]]
then
    skip_global_compinit=1
fi


export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export PATH="$PYENV_DIR/bin:$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
