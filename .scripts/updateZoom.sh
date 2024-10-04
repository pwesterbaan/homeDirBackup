#!/bin/bash

FILE=/tmp/zoom_amd64.deb
URL=https://zoom.us/client/latest/zoom_amd64.deb
if ! [ $(find /tmp/ -maxdepth 1 -name $(basename $FILE) -mtime -1) ];
then
    echo "********************************************************************************"
    echo "Install file older than 1 day, or non-existent. Downloading new:";
    echo "********************************************************************************"
    wget -O $FILE $URL
    touch $FILE
fi
sudo dpkg -i $FILE
