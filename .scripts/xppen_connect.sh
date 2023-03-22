#!/bin/bash

SCREENNAME=$(xrandr | awk '/HDMI-2/ { print $1}')
DEVID=$(xinput | awk '/UGTABLET 6 inch PenTablet Pen/ { print $9}' | cut -d '=' -f 2 | head -n 1)

xinput map-to-output $DEVID $SCREENNAME
