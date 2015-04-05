#!/bin/bash

self=`basename $0`

case "$ACTION" in
    init)
        echo "$self: INIT"
        # exit 1 # non-null exit to make gphoto2 call fail
        ;;
    start)
        echo "$self: START"
        ;;
    download)
        echo "$self: DOWNLOAD to $ARGUMENT"
        TYPE=`file --mime-type -b "$ARGUMENT"`
        if [ "$TYPE" = 'image/x-canon-cr2' ]; then

           ufraw-batch --rotate=camera \
              --compression=95 --out-type=jpg \
              --embedded-image \
              --overwrite "$ARGUMENT"
        fi

        ;;
    stop)
        echo "$self: STOP"
	python /home/pi/Pi50DBackup/send_done.py
	wget -q --tries=3 --timeout=5 -O - http://google.com > /dev/null
    	if [[ $? -eq 0 ]]; then
		echo "could try to upload now"
		for file in /home/pi/temp50DPhotos/*.jpg
		do
		    if [ -f "${file}" ]; then
			    /usr/bin/perl /home/pi/Pi50DBackup/PiwigoUpload.pl --file=${file}
		    fi
		done
		for file in /home/pi/temp50DPhotos/*.cr2
		do
		    if [ -f "${file}" ]; then
			/usr/bin/perl /home/pi/Pi50DBackup/MoveToCIFS.pl --file=${file}
		    fi
		done
#	python /home/pi/Pi50DBackup/send_get.py
	fi
        ;;
    *)
        echo "$self: Unknown action: $ACTION"
        ;;
esac

exit 0
