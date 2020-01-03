# Preferred editor for local and remote sessions
if which vim &> /dev/null
then
	export EDITOR='vim'
else
	export EDITOR='vi'
fi

eval "$(starship init zsh)"
