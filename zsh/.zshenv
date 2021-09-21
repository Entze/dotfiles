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

export PYENV_ROOT="$HOME"/Apps/pyenv

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:$HOME/.local/bin:$HOME/Apps/.bin:$HOME/.cargo/bin:$NPM_PACKAGES/bin:$PYENV_ROOT/bin"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}


# gpg
GPG_TTY=$(tty)
export GPG_TTY

# ssh
export SSH_KEY_PATH="$HOME"/.ssh/id_rsa

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
