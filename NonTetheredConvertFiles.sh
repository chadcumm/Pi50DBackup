#!/bin/bash

self=`basename $0`

echo "$self: INIT"
        echo "$self: DOWNLOAD to $ARGUMENT"
        TYPE=`file --mime-type -b "$ARGUMENT"`
        if [ "$TYPE" = 'image/x-canon-cr2' ]; then

           ufraw-batch --rotate=camera \
              --compression=95 --out-type=jpg \
              --embedded-image \
              --overwrite "$ARGUMENT"
        fi

	wget -q --tries=3 --timeout=5 -O - http://google.com > /dev/null
    	if [[ $? -eq 0 ]]; then
        	echo "$self: ONLINE"
		origin_file=$ARGUMENT
		upload_file=${ARGUMENT%.*}
		upload_filename="$upload_file.embedded.jpg"
		echo "$self upload: $upload_filename"
		/usr/bin/perl /home/pi/Pi50DBackup/PiwigoUpload.pl --file=$upload_filename &

		/bin/df -t cifs | grep //192.168.1.1/Data > /dev/null
	    	if [[ $? -eq 0 ]]; then
			/usr/bin/perl /home/pi/Pi50DBackup/MoveToCIFS.pl --file=$origin_file &
		fi
    	else
        	echo "$self: Not online"
    	fi
        ;;
    stop)
        echo "$self: STOP"
	wget -q --tries=3 --timeout=5 -O - http://google.com > /dev/null
    	if [[ $? -eq 0 ]]; then
		echo "could try to upload now"
		for file in /home/pi/temp50DPhotos/*.jpg
		do
		    if [ -f "${file}" ]; then
			    /usr/bin/perl /home/pi/Pi50DBackup/PiwigoUpload.pl --file=${file} &
		    fi
		done
		for file in /home/pi/temp50DPhotos/*.cr2
		do
		    if [ -f "${file}" ]; then
			/usr/bin/perl /home/pi/Pi50DBackup/MoveToCIFS.pl --file=${file} &
		    fi
		done
	fi
        ;;
    *)
        echo "$self: Unknown action: $ACTION"
        ;;
esac

exit 0
