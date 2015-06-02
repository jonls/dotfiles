# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Setup history options and size
HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

# Update window size after every command
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set git prompt if available
# The Git prompt can be made available by running
# "git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt"
# then restart bash.
GIT_PROMPT_START="\[$(tput setaf 4)\]\w\[\$(tput sgr0)\]"
GIT_PROMPT_END=" → "
if [ -n "$SSH_CONNECTION" ]; then
	GIT_PROMPT_START="\[$(tput setaf 1)\]\h\[$(tput sgr0)\]:$GIT_PROMPT_START"
fi
if [ -d ~/.bash-git-prompt ]; then
	source ~/.bash-git-prompt/gitprompt.sh
else
	export PS1="${GIT_PROMPT_START}${GIT_PROMPT_END}"
fi

# Enable color support
case "$(uname -s)" in
  Linux)
    if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
    fi
    ;;
  Darwin)
    alias ls='ls -G'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    ;;
esac

# Enable ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Interactive (ask to overwrite) aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
