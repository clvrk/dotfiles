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
#prompt redhat
#PROMPT='[%n@%m %1~]%(#.#.$) '
PROMPT='%B[%b%F{208}%n%F{209}@%F{210}%m%f %F{141}%1~%f%B]%b%(#.#.$) '

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

# Key bindings
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"	beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"	end-of-line

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Start Tmux session
#if [ ! $(tty) = "/dev/tty1" ] && [ -z $TMUX ] && type tmux 1> /dev/null; then
#  SESSIONS=$(tmux list-sessions 2> /dev/null | grep -E 'session-[0-9]+')
#	SESSIONS_ATTACHED=$(echo $SESSIONS | grep -v "attached" | sed -E 's/:.+$//')

	# Kill orphaned sessions
	#if [[ -n $SESSIONS_ATTACHED ]]; then
		#echo $SESSIONS_ATTACHED | \
		#while IFS= read -r session; do
			#tmux kill-session -t $session
		#done
	#fi
	
#	tmux new-session -s "session-$(if [ -z $SESSIONS ]; then echo 0; else echo $SESSIONS | wc -l; fi)"
#  exit 0
#fi
