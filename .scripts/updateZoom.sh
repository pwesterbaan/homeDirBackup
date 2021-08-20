#!/bin/bash

cd /tmp
wget -O zoom_amd64.deb https://zoom.us/client/latest/zoom_amd64.deb 
sudo dpkg -i zoom_amd64.deb
cd -
