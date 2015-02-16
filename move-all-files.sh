#!/bin/bash
lockdir=/tmp/Pi50DBackupMove.lock
 if mkdir "$lockdir"
 then
     echo >&2 "successfully acquired lock"
 else
     echo >&2 "cannot acquire lock, giving up on $lockdir"
     exit 0
 fi
/usr/bin/rsync -av --ignore-existing --remove-source-files /home/pi/temp50DPhotos/ /mnt/our_bible/Pi50DBackup
