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
# OUTPUT=$(curl --connect-timeout 5 -s wttr.in/29631?format="%t+%f+%h")
OUTPUT=$(curl --connect-timeout 5 -s "wttr.in/greenwood_sc?format="%t+%f+%h"&u")
ACTUALTEMP=$(echo $OUTPUT | awk -v FS=' ' '{print $1}' | cut -c 2-)
REALFEEL=$(echo $OUTPUT| awk -v FS=' ' '{print $2}' | cut -c 2-)
HUMIDITY=$(echo $OUTPUT | awk -v FS=' ' '{print $3}')

## based on visualcrossing (max 1000 api calls/day)
## TODO: figure out how to preserve line feeds with cURL
#OUTPUT=$(curl -X GET "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/29630?unitGroup=us&elements=temp%2Cfeelslike%2Chumidity&include=current&key=RDGHQWEJMDV672H4KZCWSBS4Z&contentType=json")
# OUTPUT=$(echo $OUTPUT | grep -A 10 currentConditions)
# ACTUALTEMP=$(echo $OUTPUT | grep temp | awk -v FS=' ' '{print $3}' | cut -c -4)
# REALFEEL=$(echo $OUTPUT| grep feelslike | awk -v FS=' ' '{print $3}' | cut -c -4)
# HUMIDITY=$(echo $OUTPUT | grep humidity | awk -v FS=' ' '{print $3}')

if [ "$OUTPUT" != '' ]; then
    echo -e "$ACTUALTEMP ($REALFEEL)\n$HUMIDITY";
else
    # echo -e "";
    echo -e "\n"
fi

# WEGO=/home/peter/.scripts/go/bin/wego
# $WEGO 1 Clemson | head -n 4 | tail -n 1 #when frontend=emoji
# $WEGO 1 Clemson | head -n 6 | tail -n 4 #when frontend=ascii-art-table
