#!/bin/bash
cd /home/pi/temp50DPhotos
gphoto2 --capture-tethered --debug-logfile /home/pi/Pi50DBackup/tether.log --force-overwrite --filename=/home/pi/temp50DPhotos/%Y%m%d-%H%M%S-%03n.%C --hook-script=/home/pi/Pi50DBackup/ConvertFiles.sh
exit
