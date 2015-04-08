for file in /home/pi/temp50DPhotos/*.CR2;                 
do                     
if [ -f "${file}" ]; 
then                         
/usr/bin/perl /home/pi/Pi50DBackup/MoveToCIFS.pl --file=${file};         
fi;                 
done
