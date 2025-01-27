#!/bin/bash
#
# Orders screens from left to right using "h" for HDMI, "v" for VGA, and "l" for Laptop

### Copy backup of displays file
###cp .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml.bak .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml

LAPTOP=$(xrandr | awk '/eDP/ { print $1}')
HDMI_DISP=$(xrandr | awk '/HDMI/ { print $1}')
VGA_DISP=$(xrandr | awk '/VGA/ { print $1}')

function get_screen_name(){
    case $1 in
	h) SCREEN=HDMI ;;
	v) SCREEN=VGA  ;;
	l) SCREEN=eDP  ;;
	*) exit 1;     ;;
    esac

    echo $(xrandr | awk '/'$SCREEN'/ { print $1}');
    return 0;
    }

#default with 'hvl'
ARG_STR=${1:-'hvl'}

#clunky error checking
CMD_STR=""

LEFT_SCREEN=$(get_screen_name "${ARG_STR:0:1}" )
if [[ $? -ne 0 ]]; then
    echo "Invalid argument: ${ARG_STR:0:1}"
    exit 1;
fi

for ((i=1; i<${#ARG_STR}; i++)); do
    RIGHT_SCREEN=$(get_screen_name "${ARG_STR:i:1}" )
    if [[ $? -ne 0 ]]; then
	echo "Invalid argument: ${ARG_STR:i:1}"
	exit 1;
    fi
    CMD_STR="$CMD_STR xrandr --output $RIGHT_SCREEN --mode 1920x1080 --right-of $LEFT_SCREEN;"
    LEFT_SCREEN=$RIGHT_SCREEN
done

# since all inputs valid, execute now
eval "$CMD_STR"

if (xrandr | grep -q "HDMI-1 connected"); then
    #move panel to HDMI
    xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s $HDMI_DISP
else
    xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s $LAPTOP
fi

xfce4-panel -r
/home/peter/.scripts/start-cnky.sh
