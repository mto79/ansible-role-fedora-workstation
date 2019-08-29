# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Control history output
export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE="ls:cd:ll:pwd:ps:bg:fg:history"
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTFILESIZE=100000
export HISTSIZE=100000
shopt -s histappend
shopt -s cmdhist
PROMPT_COMMAND='history -a'