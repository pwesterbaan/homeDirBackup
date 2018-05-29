#!/bin/bash
ifconfig | grep -Po "inet addr:.+Bcast" | grep -Po "(?:\d{1,3}\.){3}\d{1,3}" > ~/Dropbox/Documents/workhorseIP.txt && cat ~/Dropbox/Documents/workhorseIP.txt
echo 'pm-suspend' | sudo at now + 1 minutes
