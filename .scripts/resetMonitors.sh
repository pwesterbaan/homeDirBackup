#!/bin/bash
#
# Orders screens from left to right using "h" for HDMI, "v" for VGA, and "l" for Laptop

### Copy backup of displays file
###cp .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml.bak .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml

function get_screen_name(){
    case $1 in
	h) screen=HDMI ;;
	v) screen=VGA  ;;
	l) screen=eDP  ;;
	*) exit 1;     ;;
    esac

    echo $(xrandr | awk '/'$screen'/ { print $1}');
    return 0;
    }

laptop=$(get_screen_name l)
hdmi_disp=$(get_screen_name h)
# vga_disp=$(get_screen_name v)

#default with 'hvl'
arg_str=${1:-'hvl'}

#clunky error checking
cmd_str=""

left_screen=$(get_screen_name "${arg_str:0:1}" )
if [[ $? -ne 0 ]]; then
    echo "Invalid argument: ${arg_str:0:1}"
    exit 1;
fi

for ((i=1; i<${#arg_str}; i++)); do
    right_screen=$(get_screen_name "${arg_str:i:1}" )
    if [[ $? -ne 0 ]]; then
	echo "Invalid argument: ${arg_str:i:1}"
	exit 1;
    fi
    cmd_str="$cmd_str xrandr --output $right_screen --mode 1920x1080 --right-of $left_screen;"
    left_screen=$right_screen
done

# since all inputs valid, execute now
eval "$cmd_str"

if (xrandr | grep -q "HDMI-1 connected"); then
    #move panel to hdmi
    xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s $hdmi_disp
else
    xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s $laptop
fi

xfce4-panel -r
/home/peter/.scripts/start-cnky.sh
