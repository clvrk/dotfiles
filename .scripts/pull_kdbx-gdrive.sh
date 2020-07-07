#!bin/bash
# Author: 	Clark Stühmer
# Description:	This scripts pulls a KeePass (*.kdbx) database file from Google Drive and opens it.
# Arguments:
#	-u | --upload
#	Uploads the file back to the remote server if changes were made
#	and overwrites the previous revision after creating a backup on the remote.
#	-n | --no-backup
#	Forces this script to not create a backup on the remote when "-u" is specified.

SCRIPT_PATH=$(dirname $0)
TEMP_DIR=$SCRIPT_PATH/tmp
TEMP_DB_PATH=$TEMP_DIR/_db.kdbx

# CONFIGURATION
GDRIVE_DIR="$HOME/Cloud/Google Drive"
REMOTE_PATH='Documents/Private/Database.kdbx'

###
if [[ -z $GDRIVE_DIR ]]; then
	echo "\"credentials.json\" not specified..."
	exit 1
fi

if [[ -z $REMOTE_PATH ]]; then
	echo "Path to remote file not specified..."
	exit 1
fi

# Create temporary directory
if [[ ! -d $TEMP_DIR ]]; then
	mkdir $TEMP_DIR
fi

# Check if previous *.kdbx exists
if [[ -f $TEMP_DB_PATH ]]; then
	printf "Previous temporary database file found, removing... "
	rm -v $TEMP_DB_PATH
	printf "Done!\n"
fi

printf "Pulling database file from remote... "
$(cd "$GDRIVE_DIR"; drive pull -piped "$REMOTE_PATH" > $TEMP_DB_PATH)
printf "Done!\n"
keepass $TEMP_DB_PATH

if [[ -f $TEMP_DB_PATH ]]; then
	printf "Removing temporary database file... "
	rm -v $TEMP_DB_PATH
	printf "Done!\n"
fi

