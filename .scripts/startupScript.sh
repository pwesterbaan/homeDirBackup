#!/usr/bin/env bash
sleep 10
home_dir="/home/peter"
cd "$home_dir"
.scripts/resetMonitors.sh

# /snap/bin/chromium --profile-directory=Default --app-id=faolnafnngnfdaknnbpnkhgohbobgegn &
# /snap/bin/chromium --profile-directory=Default --app-id=hpfldicfbfomlpcikngkocigghgafkph &
pavucontrol &
spotify &
/usr/bin/kdeconnect-indicator &

# /home/peter/.scripts/xppen_connect.sh

sleep 5
.scripts/getWeather.sh &
.scripts/start-cnky.sh
.scripts/fix_notifyd.sh
