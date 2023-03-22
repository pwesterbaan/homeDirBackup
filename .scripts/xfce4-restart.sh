#!/bin/bash

killall xfce4-panel
sleep 2
xfwm4 --replace &
xfce4-panel & 
