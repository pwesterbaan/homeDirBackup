#!/bin/bash
sleep 10
/home/peter/.scripts/resetMonitors.sh

sleep 5
/home/peter/.scripts/getWeather.sh &
/home/peter/.scripts/start-cnky.sh

/usr/bin/chromium-browser --profile-directory=Default --app-id=hpfldicfbfomlpcikngkocigghgafkph &
pavucontrol &
spotify &

/home/peter/.scripts/xppen_connect.sh
