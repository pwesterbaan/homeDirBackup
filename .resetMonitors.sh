#!/bin/bash
### Copy backup of displays file
###cp .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml.bak .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml

### xrandr to find info
xrandr --output DVI-0 --mode 1280x1024 --right-of DVI-1-0
