#!/bin/sh
# script to be used with keyboard shortcut to type current
# date in ISO-8601 format
#
# xdotool keyup shift+F12 sleep 0.1 type $(date +"%Y-%m-%d")

OLDSELECT=$(xsel --clipboard)
CURRENTDATE=$(date +"%Y-%m-%d")
echo -n $CURRENTDATE | xsel -b -i
sleep 0.1
xdotool keyup shift+F12 key Control_L+v
sleep 0.1
echo -n $OLDSELECT | xsel  --clipboard --input
