#!/bin/bash
## CCIT help page:
## https://ccit.clemson.edu/support/kb/?cat=16

if [ ! -d /home/peter/Desktop/webspace ]; then
    mkdir /home/peter/Desktop/webspace/
fi

sudo mount -t davfs -o username=pwester,rw,dir_mode=0777,file_mode=0777 https://pwester-edit.people.clemson.edu /home/peter/Desktop/webspace
