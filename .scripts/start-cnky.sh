#!/bin/bash
pkill conky
/home/peter/.scripts/getWeather.sh &
conky -p 5 -d  -c ~/.scripts/conkyrc_main &>/dev/null &
exit
