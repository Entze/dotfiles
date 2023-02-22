# shellcheck shell=bash


PS1="\$ $(pwd): "
export PS1

# shellcheck source=/dev/null
source "$ZINIT_HOME"/zinit.zsh

if [[ $OS_ID != "ubuntu" ]]
then
    autoload -Uz _zinit
    # shellcheck disable=SC2154,SC2034
    (( ${+_comps} )) && _comps[zinit]=_zinit
fi

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=10000000

setopt HIST_VERIFY
setopt EXTENDED_HISTORY    # Save each command's beginning timestamp and the duration to the history file
setopt HIST_IGNORE_ALL_DUPS  # Ignore duplicates
setopt HIST_REDUCE_BLANKS  # Trim Whitespace
setopt HIST_IGNORE_SPACE   # Don't save in history if first character is a space
setopt INC_APPEND_HISTORY  # This is default, but set for share_history
setopt SHARE_HISTORY     # Share history file amongst all Zsh sessions

zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

# Plugins
zinit ice wait lucid atload"
  bindkey '^[[A' history-substring-search-up;
  bindkey '^[OA' history-substring-search-up;
  bindkey '^[[B' history-substring-search-down;
  bindkey '^[OB' history-substring-search-down;"
zinit light zsh-users/zsh-history-substring-search

zinit ice wait lucid
zinit light zsh-users/zsh-completions

export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=32
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait lucid
zinit light dim-an/cod

# Load starship theme
zinit ice as"command" \
          from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" \
          src"init.zsh"
zinit light starship/starship


DISPLAY_T="${DISPLAY:t}"

if [[ -r "$HOME"/.zkbd/"$TERM"-"${DISPLAY_T:-$VENDOR-$OSTYPE}" ]]
then

  # shellcheck source=/dev/null
  source "$HOME"/.zkbd/"$TERM"-"${DISPLAY_T:-$VENDOR-$OSTYPE}"
  # shellcheck disable=SC2154
  bindkey -r "${key[Insert]}"
  if [[ -r $HOME/.zshkeybinds ]]
  then

  # shellcheck source=/dev/null
  source "$HOME"/.zshkeybinds

  fi
fi

function gi() {

  curl -sLw "\n" "https://www.gitignore.io/api/$*" ;

}

sudo-command-line() {

  # shellcheck disable=SC2153
  [[ -z $BUFFER ]] && zle up-history
  if [[ $BUFFER == sudo\ * ]]; then

  LBUFFER="${LBUFFER#sudo }"

  elif [[ $BUFFER == $EDITOR\ * ]]; then

  LBUFFER="${LBUFFER#"$EDITOR" }"
  LBUFFER="sudoedit $LBUFFER"

  elif [[ $BUFFER == sudoedit\ * ]]; then

  LBUFFER="${LBUFFER#sudoedit }"
  LBUFFER="$EDITOR $LBUFFER"

  else

  LBUFFER="sudo $LBUFFER"

  fi
}

zle -N sudo-command-line
# Defined shortcut keys: [Esc] [Esc]
bindkey "\e\e" sudo-command-line
bindkey -M vicmd '\e\e' sudo-command-line


builtin zstyle ':completion:*:corrections'  format ' %F{green}-- %d (errors: %e) --%f'
builtin zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
builtin zstyle ':completion:*:messages'   format ' %F{purple} -- %d --%f'
builtin zstyle ':completion:*:warnings'   format ' %F{red}-- no matches found --%f'
builtin zstyle ':completion:*'        format ' %F{yellow}-- %d --%f'

# case insensitive matching
builtin zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' min-delay 1.3

setopt interactive_comments extended_glob autocd complete_aliases


if whence -p exa > /dev/null 2>&1
then

  alias ls="exa --colour=auto"

else

  alias ls="ls --color=auto"

fi

if [[ -s "$NVM_DIR"/nvm.sh ]]
then

    # shellcheck source=/dev/null
    . "$NVM_DIR"/nvm.sh

fi

if [[ -s "$NVM_DIR"/bash_completion ]]
then

    # shellcheck source=/dev/null
    . "$NVM_DIR"/bash_completion

fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if __conda_setup="$("${MINICONDA_DIR}/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
then
    eval "$__conda_setup"
else
    if [ -f "${MINICONDA_DIR}/conda.sh" ]; then
        # shellcheck source=/dev/null
        . "${MINICONDA_DIR}/etc/profile.d/conda.sh"
    else
        export PATH="${MINICONDA_DIR}/bin:$PATH"
    fi
fi
unset __conda_setup

# shellcheck source=/dev/null
if [ -f "/home/lukas/.local/opt/miniconda/etc/profile.d/mamba.sh" ]; then
    . "/home/lukas/.local/opt/miniconda/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# shellcheck source=/dev/null
if [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
  source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi
