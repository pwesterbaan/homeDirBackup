#!/bin/bash
### Copy backup of displays file
###cp .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml.bak .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml

### xrandr to find info

# xrandr --output eDP-1 --mode 1920x1080
# xrandr --output HDMI-1 --mode 1920x1080 --left-of eDP-1
# xrandr --output VGA-1 --mode 1680x1050 --left-of HDMI-1

LAPTOP=$(xrandr | awk '/eDP/ { print $1}')
HDMI_DISP=$(xrandr | awk '/HDMI/ { print $1}')
VGA_DISP=$(xrandr | awk '/VGA/ { print $1}')

UPSTAIRS=${1:-'u'}

xrandr --output $LAPTOP --mode 1920x1080
if (xrandr | grep -q "HDMI-1 connected"); then
    case $UPSTAIRS in
	[yY][eE][sS]|[yY]|[uU])
	    xrandr --output $HDMI_DISP --mode 1920x1080 --left-of $LAPTOP
	    xrandr --output $VGA_DISP --mode 1920x1080 --left-of $HDMI_DISP
	    pacmd set-default-sink alsa_output.pci-0000_00_03.0.hdmi-surround-extra1
	    ;;
	*)
	    xrandr --output $HDMI_DISP --mode 1920x1080 --right-of $LAPTOP
	    xrandr --output $VGA_DISP --mode 1680x1050 --right-of $HDMI_DISP
	    ;;
    esac
    #move panel to HDMI
    xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s $HDMI_DISP
else
    xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s $LAPTOP
fi

xfce4-panel -r
/home/peter/.scripts/start-cnky.sh
