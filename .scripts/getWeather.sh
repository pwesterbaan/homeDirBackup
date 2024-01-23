#!/bin/bash

## Simple script to return basic weather info
## Change url below to match desired city
#URL='https://www.accuweather.com/en/us/clemson-sc/29631/weather-forecast/335501'

#wget -q -O- "$URL" | awk -F\" '/acm_RecentLocationsCarousel\.push/{print $2"\n"$4"\n"}' | head -2
#wget -qO- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print "  "$10"°"}' | head -1
#wget -qO- "$URL" | awk -F\" '/acm_RecentLocationsCarousel\.push/{print "  "$4"\n"}' | head -1

## weather Clemson, SC and then get fips code from results
# weather fips4514950 --headers=Temperature | grep Temperature | awk -v FS=' ' '{print $2 " " $3}'
# weather fips4514950 --headers="Relative Humidity" | grep Humidity | awk -v FS=' ' '{print $3}'

# weather scz010 -q --headers=Temperature | awk -v FS=' ' '{print $2 " " $3}'
# weather scz010 -q --headers="Relative Humidity" | awk -v FS=' ' '{print $3}'


## based on wttr.in
OUTPUT=$(curl -s wttr.in/29631?format="%t+%f+%h")
ACTUALTEMP=$(echo $OUTPUT | awk -v FS=' ' '{print $1}' | cut -c 2-)
REALFEEL=$(echo $OUTPUT| awk -v FS=' ' '{print $2}' | cut -c 2-)
HUMIDITY=$(echo $OUTPUT | awk -v FS=' ' '{print $3}')

if [ "$OUTPUT" != '' ]; then
    echo -e "$ACTUALTEMP ($REALFEEL)\n$HUMIDITY";
else
    # echo -e "";
    echo -e "\n\n"
fi

# WEGO=/home/peter/.scripts/go/bin/wego
# $WEGO 1 29631 | head -n 4 | tail -n 1 #when frontend=emoji
# $WEGO 1 29631 | head -n 6 | tail -n 4 #when frontend=ascii-art-table
