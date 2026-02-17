#!/usr/bin/env bash
#
# Orders screens from left to right using "h" for HDMI, "v" for VGA, and "l" for Laptop

### Copy backup of displays file
###cp .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml.bak .config/xfce4/xfconf/xfce-perchannel-xml/displays.xml

#TODO: 2025-11-03 When switching from lhv to hvl, and plugging in HDMI before awake
#      produces the following error (twice):
#
# X Error of failed request:  BadMatch (invalid parameter attributes)
#   Major opcode of failed request:  140 (RANDR)
#   Minor opcode of failed request:  21 (RRSetCrtcConfig)
#   Serial number of failed request:  37
#   Current serial number in output stream:  37
#
#      Current theory: xrandr is getting (incorrect) info from previous HDMI "monitor":
#   1920x1080 (0x3181) 136.500MHz +HSync +VSync
#        h: width  1920 start 1952 end 1984 total 2048 skew    0 clock  66.65KHz
#        v: height 1080 start 1081 end 1084 total 1111           clock  59.99Hz
#
#      Proposed fix: Find a way force refresh monitor info?

#TODO: 2025-12-07
#      Attempted fix: Switch to laptop only first (DOES NOT WORK)


function get_screen_name(){
    case $1 in
	h) screen=HDMI ;;
	v) screen=VGA  ;;
	l) screen=eDP  ;;
	*) exit 1;     ;;
    esac

    echo $(xrandr | awk '/'${screen}'/ { print $1}');
    return 0;
    }

# store directory containing this file
scriptDir=$(dirname "$0")

laptop=$(get_screen_name l)
hdmi_disp=$(get_screen_name h)
# vga_disp=$(get_screen_name v)
resolution="1920x1080" #TODO: Get max res of all screens

#default with 'hvl'
arg_str=${1:-'hvl'}

#clunky error checking
cmd_str=""

left_screen=$(get_screen_name "${arg_str:0:1}" )
if [[ $? -ne 0 ]]; then
    echo "Invalid argument: ${arg_str:0:1}"
    exit 1;
fi

#Reset to laptop only first
xrandr --output eDP-1 --mode ${resolution}

for ((i=1; i<${#arg_str}; i++)); do
    right_screen=$(get_screen_name "${arg_str:i:1}" )
    if [[ $? -ne 0 ]]; then
	echo "Invalid argument: ${arg_str:i:1}"
	exit 1;
    fi
    cmd_str="${cmd_str} xrandr --output ${right_screen} --mode ${resolution} --right-of ${left_screen};"
    left_screen=${right_screen}
done

# since all inputs valid, execute now
echo "${cmd_str}"
eval "${cmd_str}"

if (xrandr | grep -q "HDMI-1 connected"); then
    #move panel to hdmi
    xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s ${hdmi_disp}
else
    xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s ${laptop}
fi

# xfce4-panel -r
# restart notifications
pkill dunst
# restart conky
${scriptDir}/start-cnky.sh
