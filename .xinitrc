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
		xrandr --output DP-1 --mode 1920x1080 --rate 60 --same-as eDP-1
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

# Set default cursor
xsetroot -cursor_name left_ptr

[ -f ~/.xprofile ] && . ~/.xprofile

# Keyboard layout & window manager
setxkbmap de &
xwallpaper --zoom "$HOME/Pictures/Wallpapers/Architecture/wish-you-were-here-fixed.png" &

# Audio daemons
/usr/bin/jackd -r -t1000 -dalsa -dhw:CODEC -r44100 -p1024 -n3 &
pactl load-module module-jack-sink channels=2; pactl load-module module-jack-source channels=2; pacmd set-default-sink jack_out

# Fix webcam autofocus
if [[ -n $(v4l2-ctl --list-devices | grep -i "LifeCam HD-5000") ]]; then
	v4l2-ctl --device /dev/video0 -c focus_auto=0
fi

picom -b --experimental-backends
#exec openbox-session
exec bspwm
