#!/bin/bash

usage() { echo "Usage: (-i)nit, (-b)lock, (-u)nblock, (-s)hutdown, (-h)elp" 1>&2; exit 1;}

[ $# -eq 0 ] && usage
while getopts 'hibsu' arg; do
    case "${arg}" in
	i)
	    # Init
	    echo "Initializing bluetooth"
	    sudo modprobe rtbth
	    sudo rfkill unblock bluetooth
	    hcitool dev # check
	    ;;
	b)
	    # Switch off
	    echo "Switching bluetooth off"
	    sudo rfkill block bluetooth
	    ;;
	u)
	    # Switch on
	    echo "Switching bluetooth on"
	    sudo rfkill unblock bluetooth
	    ;;
	s)
	    # Shutdown
	    echo "Turning bluetooth off"
	    sudo pkill -2 rtbt
	    sudo rmmod rtbth
	    ;;
	h | *)
	    # help message
	    usage
	    ;;
    esac
done
