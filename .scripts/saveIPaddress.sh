#!/bin/bash

/sbin/ifconfig | /bin/grep "inet" | /bin/grep -Po "(?:\d{1,3}\.){3}\d{1,3}" | /usr/bin/head -n 1 > /home/peter/Dropbox/Documents/workhorseIP.txt

