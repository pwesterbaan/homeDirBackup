#!/bin/bash

ifconfig | grep "inet" | grep -Po "(?:\d{1,3}\.){3}\d{1,3}" | head -n 1 > /home/peter/Dropbox/Documents/workhorseIP.txt && cat /home/peter/Dropbox/Documents/workhorseIP.txt
