#! /bin/bash

usage () { echo "script accepts flags: (i)nit, (b)lock, (u)nblock, or (k)ill" >&2; exit 1; }

#https://github.com/loimu/rtbth-dkms
getopts "ibus:" arg;
case $arg in
    i)	# Init
	sudo modprobe rtbth
	sudo rfkill unblock bluetooth
	hcitool dev;; # check
    b)	# Switch off
	sudo rfkill block bluetooth;;
    u)	# Switch on
	sudo rfkill unblock bluetooth;;
    s)	# Shutdown
	sudo pkill -2 rtbt
	sudo rmmod rtbth;;
    ?)  # Help message
        usage
esac

echo "Done!"
