#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
PS1='[\u@\h \W]\$ '

# Start X server on login
if [[ "$(tty)" = "/dev/tty1" ]]; then
	startx
fi

# SSH-Agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi


# Export environment variables
export EDITOR="vim"
export GIT_SSH_COMMAND="ssh -i $HOME/.ssh/gh"
#export XDG_CONFIG_HOME=

source $HOME/.bash_aliases

shopt -s globstar
