#!/bin/bash


if [ ! -d /home/peter/Desktop/uDrive ]; then
    mkdir /home/peter/Desktop/uDrive/
fi
sudo mount -t cifs -o credentials=/root/smbpass.txt //home.clemson.edu/pwester /home/peter/Desktop/uDrive
