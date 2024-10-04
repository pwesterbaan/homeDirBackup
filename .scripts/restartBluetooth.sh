#! /bin/bash

usage () { echo "script accepts flags: (i)nit, (b)lock, (u)nblock, (k)ill, or (h)elp" >&2; exit 1; }

#https://github.com/loimu/rtbth-dkms
getopts "bukh" arg;
case $arg in
    b)	# Switch off
	sudo rfkill block bluetooth;;
    u)	# Switch on
	sudo rfkill unblock bluetooth;;
    k)	# Shutdown
	sudo pkill -2 rtbt
	sudo rmmod rtbth;;
    h)  # Help message
        usage;;
    ?)	# Init

	sudo modprobe rtbth
	sudo rfkill unblock bluetooth
	sleep 2
	OUTPUT=$(hcitool dev) # check
	echo "$OUTPUT"
	#TODO: add desired output of "hcitool dev"
	if ! (echo $OUTPUT | grep -q "54:35:30:D9:B8:84")
	then
	    echo "Bluetooth device not found!"
	    exit 1
	fi;;
esac

echo "Done!"
