#!/bin/bash

SCREENNAME=$(xrandr | awk '/DVI-1-0/ { print $1}')
DEVID=$(xinput | awk '/UGTABLET 6 inch PenTablet Pen/ { print $9}' | cut -d '=' -f 2)

xinput map-to-output $DEVID $SCREENNAME
