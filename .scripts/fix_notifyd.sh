#!/usr/bin/env bash

#Some combination of these commands seemed to fix my broken notifications
pkill dunst
pkill xfce4-notifyd

#check installation
# dpkg -l | grep xfce4-notifyd
#check startup
# journalctl -xe | grep notifyd
sleep 2
notify-send  "Notifications fixed!"
