# shellcheck shell=bash

local ZNAP_FOUND="false"

if [[ -r "$HOME"/Apps/zsh-plugins/zsh-snap/znap.zsh ]]
then

  # shellcheck source=/dev/null
  source "$HOME"/Apps/zsh-plugins/zsh-snap/znap.zsh

  ZNAP_FOUND="true"

  export ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )
  znap source zsh-users/zsh-syntax-highlighting

else

  printf "znap was not found\n"

fi

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=10000000

setopt HIST_VERIFY
setopt EXTENDED_HISTORY      # Save each command's beginning timestamp and the duration to the history file
setopt HIST_IGNORE_ALL_DUPS  # Ignore duplicates
setopt HIST_REDUCE_BLANKS    # Trim Whitespace
setopt HIST_IGNORE_SPACE     # Don't save in history if first character is a space
setopt INC_APPEND_HISTORY    # This is default, but set for share_history
setopt SHARE_HISTORY         # Share history file amongst all Zsh sessions

if [[ -r $HOME/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE} ]]
then

  # shellcheck source=/dev/null
  source "$HOME"/.zkbd/"$TERM"-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
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

    LBUFFER="${LBUFFER#$EDITOR }"
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

# Plugins

if [ ZNAP_FOUND = "true" ]
then

  #znap source zsh-users/zsh-history-substring-search
  znap source marlonrichert/zsh-autocomplete
  znap source zsh-users/zsh-completions
  znap source dim-an/cod

fi

builtin zstyle ':completion:*:corrections'  format ' %F{green}-- %d (errors: %e) --%f'
builtin zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
builtin zstyle ':completion:*:messages'     format ' %F{purple} -- %d --%f'
builtin zstyle ':completion:*:warnings'     format ' %F{red}-- no matches found --%f'
builtin zstyle ':completion:*'              format ' %F{yellow}-- %d --%f'

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

if whence -p pyenv > /dev/null 2>&1
then

  eval "$(pyenv init -)"

fi

if whence -p starship > /dev/null 2>&1
then

  if [ ZNAP_FOUND = "true" ]
  then

    znap eval starship "starship init zsh --print-full-init"
    znap prompt

  else

    eval "$(starship init zsh)"

  fi


else

  PS1="\$ $(pwd): "
  export PS1

fi

unset ZNAP_FOUND
