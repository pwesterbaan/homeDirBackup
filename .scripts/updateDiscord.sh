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
wget -O discord.deb "https://discord.com/api/download/stable?platform=linux&format=deb"
sudo dpkg -i discord.deb
cd -

confirm "Restart Zoom?" && pkill zoom; zoom &
