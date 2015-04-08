for file in /home/pi/temp50DPhotos/*.jpg;                 
do                     
if [ -f "${file}" ]; 
then                         
/usr/bin/perl /home/pi/Pi50DBackup/PiwigoUpload.pl --file=${file};         
fi;                 
done
