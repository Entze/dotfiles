# Preferred editor for local and remote sessions
if which vim &> /dev/null
then
	export EDITOR='vim'
else
	export EDITOR='vi'
fi

source $HOME/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# z
zplugin ice wait blockf lucid
zplugin light rupa/z

# z tab completion
zplugin ice wait lucid
zplugin light changyuheng/fz

# z / fzf (ctrl-g)
zplugin ice wait lucid
zplugin light andrewferrier/fzf-z

# zplugin ice wait lucid
zplugin light zsh-users/zsh-autosuggestions

# zplugin ice wait lucid
zplugin load zdharma/history-search-multi-word

# sudo
zplugin ice wait lucid
zplugin load hcgraf/zsh-sudo

# cd
zplugin ice wait lucid
zplugin light changyuheng/zsh-interactive-cd

# History substring searching
#zplugin ice wait lucid atload'__bind_history_keys'
zplugin light zsh-users/zsh-history-substring-search
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=10000000

setopt HIST_VERIFY
setopt EXTENDED_HISTORY      # save each command's beginning timestamp and the duration to the history file
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY    # this is default, but set for share_history
setopt SHARE_HISTORY         # Share history file amongst all Zsh sessions

source $HOME/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
# Don't bind these keys until ready
bindkey ${key[Home]} beginning-of-line
bindkey ${key[End]} end-of-line
bindkey ${key[Up]} history-substring-search-up
bindkey ${key[Down]} history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey ${key[CtrlLeft]} backward-word
bindkey ${key[CtrlRight]} forward-word
bindkey ${key[CtrlUp]} up-case-word
bindkey ${key[CtrlDown]} down-case-word
bindkey ${key[Delete]} delete-char
bindkey -r ${key[Insert]}

# autosuggestions, trigger precmd hook upon load
zplugin ice wait lucid atload'_zsh_autosuggest_start'
zplugin light zsh-users/zsh-autosuggestions
# export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10

# Tab completions
zplugin ice wait lucid blockf atpull'zplugin creinstall -q .'
zplugin light zsh-users/zsh-completions

# Syntax highlighting
zplugin ice wait lucid atinit'zpcompinit; zpcdreplay'
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait lucid
zplugin load RobSis/zsh-completion-generator

builtin zstyle ':completion:*:corrections'  format ' %F{green}-- %d (errors: %e) --%f'
builtin zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
builtin zstyle ':completion:*:messages'     format ' %F{purple} -- %d --%f'
builtin zstyle ':completion:*:warnings'     format ' %F{red}-- no matches found --%f'
builtin zstyle ':completion:*'              format ' %F{yellow}-- %d --%f'

setopt interactive_comments extended_glob autocd complete_aliases

eval "$(starship init zsh)"
