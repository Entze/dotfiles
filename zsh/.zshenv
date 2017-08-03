export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:$HOME/.cask/bin:$PATH"

fpath=( "$HOME/.zfunctions" $fpath )

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# ssh
export SSH_KEY_PATH=~/.ssh/id_rsa
