#!/usr/bin/env bash
# Found here:
# https://askubuntu.com/questions/1351356/timestamp-keyboard-shortcut

xdotool keyup ctrl+shift+F1 sleep 0.1 type $(date +"%Y-%m-%d")

# OLDSELECT=$(xsel --clipboard)
# CURRENTDATE=$(date +"%Y-%m-%d")
# echo -n $CURRENTDATE | xsel -b -i
# sleep 0.3
# xdotool keyup ctrl+shift+d key Control_L+v
# sleep 0.3s
# echo -n $OLDSELECT | xsel  --clipboard --input
