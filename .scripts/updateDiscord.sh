#!/bin/bash

cd /tmp
wget -O discord.deb "https://discord.com/api/download/stable?platform=linux&format=deb"
sudo dpkg -i discord.deb
cd -
