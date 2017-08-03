start=$(($(date +%s%N)/1000000))
# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export TERM="xterm-256color"
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
 CASE_SENSITIVE="false"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
 HYPHEN_INSENSITIVE="false"

# Uncomment the following line to disable bi-weekly auto-update checks.
  DISABLE_AUTO_UPDATE="false"

# Uncomment the following line to change how often to auto-update (in days).
 export UPDATE_ZSH_DAYS=30

# Uncomment the following line to disable colors in ls.
 DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
 DISABLE_AUTO_TITLE="false"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="false"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
 DISABLE_UNTRACKED_FILES_DIRTY="false"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
 HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fedora common-aliases sudo)

# User configuration

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
 export SSH_KEY_PATH=~/.ssh/id_rsa

# gpg
 GPG_TTY=$(tty)
 export GPG_TTY


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias cw='clear && welcome_message'

#
# VPN
alias vpn_tu='sudo openconnect --user e1526001@student.tuwien.ac.at https://vpn.tuwien.ac.at'

##################
# custom section #
##################

DISABLE_AUTO_TITLE="true"

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

welcome_message (){
RNG_COLOR=$(print -P $(uname -r && date +'%T%N') | sha1sum | tr -dc '0-9' | grep -o -m1 -E "[[:digit:]]{5}" | grep -o -m1 -E "[1-9][[:digit:]]{4}" | tr -dc '0-9')
RNG_COLOR=$(( $RNG_COLOR % 255 ))
if (($RNG_COLOR < 100)); then
    RNG_COLOR="0$RNG_COLOR"
fi

# welcome message
print -P "$reset_color$(date +"%F") $FG[$RNG_COLOR]$(date +"%T"),$reset_color $(date +"%A"), $(date +"%d"). $(date +"%B")\n$FG[069]$(cat /etc/os-release | grep -E '^PRETTY_NAME="' | sed 's/\(^PRETTY_NAME="\)\(.*\)\("$\)/\2/')$reset_color on $fg[blue]$(uname) $(uname -r)$reset_color\n\c"
}
welcome_message
finished=$(( $(date +%s%N) / 1000000 ))
zshrc-analyze(){
readTime=$(( finished - start))
readTime=$(print -P $readTime | sed 's/\(.\)\(...\)$/\1.\2s/;t;s/^...$/0.&s/;t;s/^..$/0.0&s/;t;s/^.$/0.00&s/')
print -P "zshrc was loaded in $readTime"
}
