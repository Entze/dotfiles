# shellcheck shell=bash

# Preferred editor for local and remote sessions
if whence -p vim >/dev/null 2>&1; then
   export VISUAL="vim"
else
   export VISUAL="vi"
fi
export EDITOR=${VISUAL}
export XDG_BIN_HOME=${XDG_BIN_HOME:-${HOME}/.local/bin}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-${HOME}/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-${HOME}/.local/state}
export INSTALL_DIR=${INSTALL_DIR:-${HOME}/.local/opt}

# ghcup
export GHCUP_USE_XDG_DIRS=1

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

# github
if [[ -r $HOME/.github/ENV ]]; then
   # shellcheck disable=SC2086
   # shellcheck source=/dev/null
   source $HOME/.github/ENV
fi

if [[ -r $XDG_CONFIG_HOME/.github/ENV ]]; then
   # shellcheck disable=SC2086
   # shellcheck source=/dev/null
   source $XDG_CONFIG_HOME/.github/ENV
fi

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# ssh
if [[ -r $XDG_CONFIG_HOME/.ssh/id_ecdsa ]]; then
   export SSH_KEY_PATH=$XDG_CONFIG_HOME/.ssh/id_ecdsa
fi
if [[ -r $XDG_CONFIG_HOME/.ssh/id_ed25519 ]]; then
   export SSH_KEY_PATH=$XDG_CONFIG_HOME/.ssh/id_ed25519
fi
if [[ -r $XDG_CONFIG_HOME/.ssh/id_rsa ]]; then
   export SSH_KEY_PATH=$XDG_CONFIG_HOME/.ssh/id_rsa
fi

if [[ -r $HOME/.ssh/id_ecdsa ]]; then
   export SSH_KEY_PATH=$HOME/.ssh/id_ecdsa
fi
if [[ -r $HOME/.ssh/id_ed25519 ]]; then
   export SSH_KEY_PATH=$HOME/.ssh/id_ed25519
fi
if [[ -r $HOME/.ssh/id_rsa ]]; then
   export SSH_KEY_PATH=$HOME/.ssh/id_rsa
fi

OS_ID=$(grep -E '^ID="?[a-zA-Z]*"?$' /etc/os-release | sed -E 's/(^ID="?)([a-zA-Z]*)("?$)/\2/')
export OS_ID

if [[ $OS_ID = "ubuntu" ]]; then
   export skip_global_compinit=1
fi

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export PATH=$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin:$XDG_BIN_HOME:$PATH
