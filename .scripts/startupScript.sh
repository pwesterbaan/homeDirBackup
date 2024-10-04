#!/bin/bash
sleep 10
/home/peter/.scripts/resetMonitors.sh

# /snap/bin/chromium --profile-directory=Default --app-id=faolnafnngnfdaknnbpnkhgohbobgegn &
# /snap/bin/chromium --profile-directory=Default --app-id=hpfldicfbfomlpcikngkocigghgafkph &
pavucontrol &
spotify &
/usr/bin/kdeconnect-indicator &

# /home/peter/.scripts/xppen_connect.sh

sleep 5
/home/peter/.scripts/getWeather.sh &
/home/peter/.scripts/start-cnky.sh
