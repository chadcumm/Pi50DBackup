#!/bin/bash
lockdir=/tmp/Pi50DBackup.lock
lockfile=/tmp/Pi50DBackupCopy.lock
if mkdir "$lockdir"
then
     echo >&2 "successfully acquired lock"

DEVICE=$(gphoto2 --auto-detect | grep usb | cut -b 36-42 | sed 's/,/\//')
while [ -z ${DEVICE} ]
        do
        sleep 1
        DEVICE=$(gphoto2 --auto-detect | grep usb | cut -b 36-42 | sed 's/,/\//')
done
cd /home/pi/temp50DPhotos
touch $lockfile
gphoto2 --get-all-files --force-overwrite
#exiftool -r -d %Y%m%d-%H%M%S.%%e "-FileName<DateTimeOriginal" .
rm $lockfile

     # Remove lockdir when the script finishes, or when it receives a signal
     trap 'rm -rf "$lockdir"' 0    # remove directory when script finishes

else
     echo >&2 "cannot acquire lock, giving up on $lockdir"
     exit 0
fi

