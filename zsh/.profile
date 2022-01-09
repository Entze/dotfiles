export PYENV_ROOT="${PYENV_ROOT:-${XDG_DATA_HOME:-${HOME}/.local/share}/pyenv}"
export PYENV_DIR="${PYENV_DIR:-${PYENV_ROOT}/pyenv.git}"

if [ -d "$PYENV_DIR/bin" ]
then

  eval "$("${PYENV_DIR}"/bin/pyenv init --path)"

fi
