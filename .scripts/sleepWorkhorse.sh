#!/bin/bash

# log ipAddress and suspend system

/home/peter/.scripts/saveIPaddress.sh
/bin/cat /home/peter/Dropbox/Documents/workhorseIP.txt
sleep 5
systemctl suspend
#sudo service network-manager restart
#echo 'systemctl suspend' | sudo at now +1 minutes
