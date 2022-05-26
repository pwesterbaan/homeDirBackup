#!/bin/sh

## Simple script to return basic weather info
## Change url below to match desired city
#URL='https://www.accuweather.com/en/us/clemson-sc/29631/weather-forecast/335501'

#wget -q -O- "$URL" | awk -F\" '/acm_RecentLocationsCarousel\.push/{print $2"\n"$4"\n"}' | head -2
#wget -qO- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print "  "$10"°"}' | head -1
#wget -qO- "$URL" | awk -F\" '/acm_RecentLocationsCarousel\.push/{print "  "$4"\n"}' | head -1

## weather Clemson, SC and then get fips code from results
# weather fips4514950 --headers=Temperature | grep Temperature | awk -v FS=' ' '{print $2 " " $3}'
# weather fips4514950 --headers="Relative Humidity" | grep Humidity | awk -v FS=' ' '{print $3}'

weather scz010 -q --headers=Temperature | awk -v FS=' ' '{print $2 " " $3}'
weather scz010 -q --headers="Relative Humidity" | awk -v FS=' ' '{print $3}'

