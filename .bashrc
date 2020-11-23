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

# Export environment variables
export GIT_SSH_COMMAND="ssh -i $HOME/.ssh/gh"
#export XDG_CONFIG_HOME=

# Set aliases
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lhA'
alias rm='rm -v'
alias cp='cp -v'
alias mv='mv -v'
alias bpct='echo "Battery: $(cat /sys/class/power_supply/BAT0/capacity)%"'
alias dotfiles='git --git-dir=$HOME/Documents/git-repos/dotfiles.git --work-tree=$HOME'
alias cdgit='cd $HOME/Documents/git-repos'
alias r='ranger'
alias vim='nvim'
alias v='nvim'
#alias newsboat='newsboat --cache-file $HOME/.config/.newsboat/cache.db --config-file $HOME/.config/.newsboat/config --url-file $HOME/.config/.newsboat/urls'
alias kp='sh $HOME/.scripts/pull_kdbx-gdrive.sh -c keepassxc -i'
alias dpull='pushd "$HOME/Cloud/Google Drive" 1> /dev/null && sh $HOME/.scripts/sync-gdrive.sh pull synclist.txt && popd 1> /dev/null'
alias grabwav='youtube-dl --no-playlist -x --audio-format wav -o "$HOME/Music/Samples/%(title)s_%(id)s.%(ext)s"'
