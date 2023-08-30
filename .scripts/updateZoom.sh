#!/bin/bash

confirm(){
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            if [[ $response != n && $* == *-y* ]]; then
              true
            else
              false
            fi
            ;;
    esac
}

cd /tmp
wget -O zoom_amd64.deb https://zoom.us/client/latest/zoom_amd64.deb
sudo dpkg -i zoom_amd64.deb
cd -

if confirm "Restart Zoom? (default no)"; then pkill zoom; zoom & fi
