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
        ;;
    *)
        echo "$self: Unknown action: $ACTION"
        ;;
esac

exit 0
