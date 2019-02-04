start=$(($(date +%s%N)/1000000))

# export TERM="xterm-256color"

source $HOME/.zsh/plugins/cp/cpv.zsh
source $HOME/.zsh/plugins/sudo/sudo.zsh
source $HOME/.zsh/plugins/zsh-git-promt/zshrc.sh
source $HOME/.zsh/plugins/extract/extract.zsh
source $HOME/.zsh/themes/zsh-prompt/lambda-mod.zsh-theme
source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000000
SAVEHIST=100000000

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

autoload -U compinit && compinit
zmodload -i zsh/complist

unsetopt menu_complete
unsetopt flowcontrol
unsetopt flow_control

setopt prompt_subst
setopt always_to_end
setopt auto_menu
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history_time
setopt interactivecomments
setopt interactive_comments

bindkey -v

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Preferred editor for local and remote sessions
if which vim &> /dev/null
then
	export EDITOR='vim'
else
	export EDITOR='vi'
fi

alias cw='clear && welcome_message'

##################
# custom section #
##################

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

function welcome_message () {
	RNG_COLOR=$(shuf -i 0-255 -n 1 2> /dev/null)
	if (($RNG_COLOR < 100)); then
		RNG_COLOR="0$RNG_COLOR"
	fi
	
	# welcome message
	
	print -P "$reset_color$(date +"%F") $FG[$RNG_COLOR]$(date +"%T"),$reset_color $(date +"%A"), $(date +"%d"). $(date +"%B")\n$fg[blue]$(grep -F 'PRETTY_NAME="' /etc/os-release | sed 's/\(^PRETTY_NAME="\)\(.*\)\("$\)/\2/')$reset_color on $FG[208]$(uname) $(uname -r)$reset_color\n\c"

}
welcome_message
finished=$(( $(date +%s%N) / 1000000 ))

function zshrc-analyze() {
  readTime=$(( finished - start ))
  readTime=$(print -P $readTime | sed 's/\(.\)\(...\)$/\1.\2s/;t;s/^...$/0.&s/;t;s/^..$/0.0&s/;t;s/^.$/0.00&s/')
  print -P "zshrc was loaded in $readTime"
}
