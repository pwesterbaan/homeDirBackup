#!/usr/bin/env bash

#Some combination of these commands seemed to fix my broken notifications
pkill dunst
sleep 1
pkill xfce4-notifyd

#check installation
# dpkg -l | grep xfce4-notifyd
#check startup
# journalctl -xe | grep notifyd

xfce4-notifyd-config
# sleep 2
notify-send  "Notifications fixed!"
