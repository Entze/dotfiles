export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:$HOME/.cask/bin:$HOME/Apps/.bin:$PATH"

fpath=( "$HOME/.zfunctions" $fpath )

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# ssh
export SSH_KEY_PATH="$HOME/.ssh/id_rsa"

export JAVA_HOME=$(find /opt/jdk -mindepth 1 -maxdepth 1 | sort | tail --lines=1)
