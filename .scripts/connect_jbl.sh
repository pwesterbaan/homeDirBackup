#! /bin/bash

export jbl_mac=74:2A:8A:A6:2F:C3
export ralink_mac=54:35:30:D9:B8:84

if ! (hcitool dev | grep -q $ralink_mac)
then
    /home/peter/.scripts/restartBluetooth.sh;
    if [[ $? -ne 0 ]]
    then
	echo "Failed restarting Bluetooth"
	exit $?
    fi
    sleep 5;
fi;

blueman-manager &

# OUTPUT=$(bluetoothctl connect $jbl_mac)
# echo "$OUTPUT"
# if (echo $OUTPUT | grep br-connection-unknown)
# then
#     echo "Attempting to reconnect by removing and re-pairing"
#     bluetoothctl untrust $JBL_MAC & sleep 2;
#     bluetoothctl remove $JBL_MAC & sleep 2;
#     bluetoothctl trust $JBL_MAC & sleep 2;
#     bluetoothctl pair $JBL_MAC & sleep 2;
#     bluetoothctl connect $JBL_MAC
# fi;
