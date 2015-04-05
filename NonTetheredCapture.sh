#!/bin/bash
cd /home/pi/temp50DPhotos
python /home/pi/Pi50DBackup/send_start.py
gphoto2 --get-all-files --debug-logfile /home/pi/Pi50DBackup/tether.log --force-overwrite --filename=/home/pi/temp50DPhotos/%Y%m%d-%H%M%S-%03n.%C --hook-script=/home/pi/Pi50DBackup/ConvertFiles.sh
python /home/pi/Pi50DBackup/send_get.py
exit
