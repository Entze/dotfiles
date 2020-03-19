# Preferred editor for local and remote sessions
if which vim &> /dev/null
then
    export EDITOR='vim'
else
    export EDITOR='vi'
fi

source $HOME/.zsh_plugins.sh

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
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY    # this is default, but set for share_history
setopt SHARE_HISTORY         # Share history file amongst all Zsh sessions

if [[ -r "$HOME/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}" ]]
then
    source $HOME/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}

    bindkey -r ${key[Insert]}

    if [[ -r "$HOME/.zshkeybinds" ]]
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

function gi() { curl -sLw "\n" https://www.gitignore.io/api/$@ ;}

if [ -r "$HOME/.nord-dircolors/src/dir_colors" ]
then
    eval $(dircolors "$HOME/.nord-dircolors/src/dir_colors")
fi

alias ls="ls --color=auto"

export PS1="\$ $(pwd): "

if starship --version 2>&1 1>/dev/null
then
    eval "$(starship init zsh)"
fi
