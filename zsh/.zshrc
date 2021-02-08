if [[ -r /usr/share/zsh-antigen/antigen.zsh ]]
then

  source /usr/share/zsh-antigen/antigen.zsh

  antigen bundle zsh-users/zsh-history-substring-search
  antigen bundle zsh-users/zsh-completions
  antigen bundle zsh-users/zsh-syntax-highlighting

  antigen apply

fi

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done

compinit -C

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=10000000

setopt HIST_VERIFY
setopt EXTENDED_HISTORY      # save each command's beginning timestamp and the duration to the history file
setopt HIST_IGNORE_ALL_DUPS  # Ignore duplicates
setopt HIST_REDUCE_BLANKS    # Trim Whitespace
setopt HIST_IGNORE_SPACE     # Don't save in history if first character is a space
setopt INC_APPEND_HISTORY    # this is default, but set for share_history
setopt SHARE_HISTORY         # Share history file amongst all Zsh sessions

if [[ -r $HOME/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE} ]]
then
  source $HOME/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
  bindkey -r ${key[Insert]}
  if [[ -r $HOME/.zshkeybinds ]]
  then
    source $HOME/.zshkeybinds
  fi
fi


builtin zstyle ':completion:*:corrections'  format ' %F{green}-- %d (errors: %e) --%f'
builtin zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
builtin zstyle ':completion:*:messages'     format ' %F{purple} -- %d --%f'
builtin zstyle ':completion:*:warnings'     format ' %F{red}-- no matches found --%f'
builtin zstyle ':completion:*'              format ' %F{yellow}-- %d --%f'

# case insensitive matching
builtin zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

setopt interactive_comments extended_glob autocd complete_aliases

function gi() {

  curl -sLw "\n" https://www.gitignore.io/api/$@ ;

}

sudo-command-line() {

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

if whence -p exa 2>&1 1>/dev/null
then
  alias ls="exa --colour=auto"
else
  alias ls="ls --color=auto"
fi


if whence -p starship 2>&1 1>/dev/null
then
  eval "$(starship init zsh)"
else
  export PS1="\$ $(pwd): "
fi
