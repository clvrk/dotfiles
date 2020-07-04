#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Start X server on login
if [[ "$(tty)" = "/dev/tty1" ]]; then
	startx
fi

# Set aliases
alias ll='ls -l'
alias bpct='echo "Battery: $(cat /sys/class/power_supply/BAT0/capacity)%"'
alias dotfiles='git --git-dir=$HOME/Documents/git-repos/dotfiles --work-tree=$HOME'
