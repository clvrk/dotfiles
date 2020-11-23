#!/bin/sh
# Author:	Clark Michael
# Description:	Network traffic module for Polybar	

cache_dir="$HOME/.cache/polybar-module_network-traffic"
interface='*'
declare -A PREFIXES

[ -d $cache_dir ] || mkdir $cache_dir

i=1
while [ ! -z "${!i}" ]
do
	nextIndex=$((i+1))

	case ${!i} in
		"-i") interface="${!nextIndex}" ;;
		"--rx-prefix") PREFIXES[rx]="${!nextIndex}" ;;
		"--tx-prefix") PREFIXES[tx]="${!nextIndex}" ;;
	esac

	i=$((i+1))	
done

mode="rx"

if [ -z "$(ls /sys/class/net/${interface} 2>&1 1> /dev/null)" ]
then
	for mode in rx tx
	do
		bytefile="$cache_dir/${mode}_bytes"
		bytes_previous=$(cat $bytefile)
		bytes_current=$(($(cat /sys/class/net/${interface}/statistics/${mode}_bytes | paste -sd '+')))
		echo $bytes_current > $bytefile

		bytes_diff="$((($bytes_current-$bytes_previous)/1024))"
		printf "%s%4d %5s" "${PREFIXES[$mode]}" "$bytes_diff" "KiB/s$([ $mode = tx ] || echo ' ')"
	done
else
	echo "Network interface \"${interface}\" does not exist"
fi
