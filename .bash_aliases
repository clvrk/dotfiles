# Set aliases
alias ls='exa --color=auto -g'
alias ll='ls -l'
alias la='ls -la'
alias rm='rm -v'
alias cp='cp -v'
alias mv='mv -v'
alias ssh='TERM=xterm-256color /usr/bin/ssh'
alias tmux='tmux -2 -f "$HOME/.config/tmux/tmux.conf"'
alias bpct='echo "Battery: $(cat /sys/class/power_supply/BAT0/capacity)%"'
alias dotfiles='git --git-dir=$HOME/Documents/git-repos/dotfiles.git --work-tree=$HOME'
alias cdgit='cd $HOME/Documents/git-repos'
alias r='ranger'
alias vim='nvim'
alias v='nvim'
alias kp='sh $HOME/.scripts/pull_kdbx-gdrive.sh -c keepassxc -r gdrive -i'
alias grabwav='youtube-dl --no-playlist -x --audio-format wav -o "$HOME/Music/Samples/%(title)s_%(id)s.%(ext)s"'
