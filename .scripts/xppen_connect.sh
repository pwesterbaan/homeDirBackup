#!/bin/bash

SCREENNAME=$(xrandr | awk '/VGA/ { print $1}')
DEVID=$(xinput | awk '/UGTABLET 6 inch PenTablet Pen/ { print $9}' | cut -d '=' -f 2)

xinput map-to-output $DEVID $SCREENNAME
