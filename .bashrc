# Setup history options and size
HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

# Update window size after every command
shopt -s checkwinsize

# Set git prompt if available
GIT_PROMPT_START="\[$(tput setaf 4)\]\w\[\$(tput sgr0)\]"
GIT_PROMPT_END=" → "
if [ -d ~/.bash-git-prompt ]; then
	source ~/.bash-git-prompt/gitprompt.sh
else
	export PS1="${GIT_PROMPT_START}${GIT_PROMPT_END}"
fi

# Enable color support
alias ls='ls -G'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
