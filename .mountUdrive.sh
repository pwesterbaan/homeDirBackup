#!/bin/bash

mkdir ~/Desktop/uDrive/
sudo mount -t cifs -o credentials=/root/smbpass.txt //home.clemson.edu/pwester /home/peter/Desktop/uDrive
