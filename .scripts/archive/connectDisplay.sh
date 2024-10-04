#!/bin/bash

## Following link provides tips on multiscreen setup
## Follow this to restrict the xp-pen to one display only
# https://wiki.archlinux.org/index.php/wacom_tablet#Multiscreen_setup
# xinput list
# xinput map-to-output 24 VGA-1

### Copy backup of displays file
###cp .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml.bak .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml

### xrandr to find info

### use when left screen in 2nd card

LAPTOP=$(xrandr | awk '/eDP/ { print $1}')
HDMI_DISP=$(xrandr | awk '/HDMI/ { print $1}')
VGA_DISP=$(xrandr | awk '/VGA/ { print $1}')

xrandr --output $LAPTOP --mode 1920x1080
# xrandr --output $HDMI_DISP --primary --mode 1920x1080 --left-of $LAPTOP
xrandr --output $HDMI_DISP --mode 1920x1080 --left-of $LAPTOP
xrandr --output $VGA_DISP --mode 1920x1080 --left-of $HDMI_DISP

pacmd set-default-sink alsa_output.pci-0000_00_03.0.hdmi-surround-extra1
bash ~/.scripts/start-cnky.sh
