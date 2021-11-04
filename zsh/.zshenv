# shellcheck shell=bash

# Preferred editor for local and remote sessions
if whence -p vim > /dev/null 2>&1
then
  export VISUAL="vim"
else
  export VISUAL="vi"
fi
export EDITOR="$VISUAL"

NPM_PACKAGES="$HOME"/.npm-packages

export PATH="$HOME/.cargo/bin:$NPM_PACKAGES/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin:$HOME/.local/bin:$HOME/Apps/.bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

export GHCUP_USE_XDG_DIRS=1

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

if [[ -r "$HOME"/.github/ENV ]]
then
   # shellcheck disable=SC1090
   source "$HOME"/.github/ENV
fi

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# ssh
export SSH_KEY_PATH="$HOME"/.ssh/id_rsa

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
