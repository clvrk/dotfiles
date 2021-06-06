# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# (Un)set options
set -o magicequalsubst
unsetopt autocd

bindkey -v
bindkey -- "${terminfo[khome]}" beginning-of-line
bindkey -- "${terminfo[kend]}"  end-of-line
bindkey -- "${terminfo[kdch1]}" delete-char
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/clark/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit

# Set prompt theme
prompt redhat

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
export GIT_SSH_COMMAND="ssh -i $HOME/.ssh/gh"

# Load aliases
source $HOME/.bash_aliases

# Source zsh extensions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
