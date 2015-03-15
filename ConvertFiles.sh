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

	wget -q --tries=2 --timeout=3 -O - http://google.com > /dev/null
    	if [[ $? -eq 0 ]]; then
        	echo "$self: ONLINE"
		upload_file=${ARGUMENT%.*}
		echo "$self upload: $upload_file.embedded.jpg"
		/usr/bin/perl /home/pi/Pi50DBackup/PiwigoUpload.pl --file=$upload_file
    	else
        	echo "$self: Not online"
    	fi
        ;;
    stop)
        echo "$self: STOP"
        ;;
    *)
        echo "$self: Unknown action: $ACTION"
        ;;
esac

exit 0
