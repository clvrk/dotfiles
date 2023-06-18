HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

fpath+=($HOME/Documents/git-repos/pure)

autoload -Uz compinit promptinit
compinit
promptinit

prompt pure

# Source plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init --cmd cd zsh)"

# SSH Agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
fi

# Source environment variables
source ~/.zshenv

if [[ ! $TMUX ]]; then
	tmux
fi
