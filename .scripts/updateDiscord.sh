#!/bin/bash

# cd /tmp
# wget -O discord.deb
# sudo dpkg -i discord.deb
# cd -

#!/bin/bash

FILE=/tmp/discord.deb
URL="https://discord.com/api/download/stable?platform=linux&format=deb"
if ! [ $(find /tmp/ -maxdepth 1 -name $(basename $FILE) -mtime -1) ];
then
    echo "********************************************************************************"
    echo "Install file older than 1 day, or non-existent. Downloading new:";
    echo "********************************************************************************"
    wget -O $FILE $URL
    touch $FILE
fi
sudo dpkg -i $FILE
