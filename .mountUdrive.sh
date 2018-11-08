#!/bin/bash


if [ ! -d ~/Desktop/uDrive ]; then
    mkdir ~/Desktop/uDrive/
fi
sudo mount -t cifs -o credentials=/root/smbpass.txt //home.clemson.edu/pwester /home/peter/Desktop/uDrive
