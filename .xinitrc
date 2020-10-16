#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
#
if [ -f $sysresources ]; then
	xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
	xmodmap $sysmodmap
fi

# User resources
if [ -f "$userresources" ]; then
	# Query amount of displays
	NUM_DISPLAYS=$(xrandr | grep -E "\sconnected" | wc -l)

	xrdb -merge "$userresources" -DNUM_DISPLAYS=$NUM_DISPLAYS

	if [[ ! -z $(xrandr | grep -E "^DP-1 connected") ]]; then
		xrandr --output DP-1 --auto --same-as eDP-1
		xbacklight -set 0
	fi
fi

if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Export environment variables
export PATH="$PATH:$HOME/bin:$HOME/.gem/ruby/2.7.0/bin"
export USER_TERMINAL="urxvt"
export USER_FILEMANAGER="ranger"

# Keyboard layout & window manager
setxkbmap de &
xwallpaper --zoom "$HOME/Pictures/Wallpapers/Architecture/wall01.png" &

# Audio daemons
[ ! -z $(pacman -Qqs qjackctl) ] && qjackctl &
[ ! -z $(pacman -Qqs cadence) ] && cadence-session-start --start &

picom -b --experimental-backends
exec bspwm
