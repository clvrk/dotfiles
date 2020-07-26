#!/bin/bash
# Author:	Clark Stühmer
# Description:	This script is used to sync my personal files from Google Drive using drive ().
# Arguments:
#         0:	"pull" or "push" to perform these action respectively.
#         1:	Path to text-file with each line representing a path to a directory or file to sync.

GLOBAL_SYNC_ARGS='-no-prompt -fix-clashes'

echo "Reading entries from $(basename "$2")..."

while IFS='' read -r line
do
	if [[ ! -z $line ]]
	then
		echo "[$line]" 

		case $1 in
			"pull")	drive pull $GLOBAL_SYNC_ARGS "$line" ;;
			"push") drive push $GLOBAL_SYNC_ARGS "$line" ;;
		esac
	fi
done < $2

echo "Done syncing!"
