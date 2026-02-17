#!/usr/bin/env bash

# screenname=$(xrandr | awk '/eDP/ { print $1}')
screenname=$(xrandr | awk '/HDMI/ { print $1}')
devid=$(xinput | awk '/UGTABLET 6 inch PenTablet Pen/ { print $9}' | cut -d '=' -f 2)

xinput map-to-output $devid $screenname
