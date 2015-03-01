#!/bin/bash
lockdir=/tmp/Pi50DBackupMove.lock
 if mkdir "$lockdir"
 then
     echo >&2 "successfully acquired lock"

	trap 'rm -rf "$lockdir"; exit $?' INT TERM EXIT


#/usr/bin/rsync -av --ignore-existing --remove-source-files /home/pi/temp50DPhotos/ /mnt/our_bible/Pi50DBackup
/usr/bin/rsync -av --remove-source-files --include='*.CR2' --include=".JPG"  /home/pi/temp50DPhotos/ /mnt/our_bible/Pi50DBackup
#python /home/pi/Pi50DBackup/send_copy.py

     # Remove lockdir when the script finishes, or when it receives a signal
     trap 'rm -rf "$lockdir"' 0    # remove directory when script finishes
 else
     echo >&2 "cannot acquire lock, giving up on $lockdir"
     exit 0
fi
