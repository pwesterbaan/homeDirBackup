#!/bin/bash
### Copy backup of displays file
###cp .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml.bak .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml

### xrandr to find info

### use when left screen in 2nd card
### xrandr --output DVI-0 --mode 1280x1024 --right-of DVI-1-0

xrandr --output VGA-0 --mode 1152x864 --left-of DVI-0
sleep 2
xrandr --output VGA-0 --mode 1280x1024 --left-of DVI-0
