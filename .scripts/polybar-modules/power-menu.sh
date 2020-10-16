#!/bin/sh
# Author: Clark Michael
# Description: 

case $(echo -e "Shutdown\nReboot" | rofi -dmenu -theme-str 'entry { enabled: false;}' -p "Power") in
	"Shutdown") shutdown now ;;
	"Reboot") reboot ;;
esac
