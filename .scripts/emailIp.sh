#!/bin/sh

## send email containing IP address
## https://media.yuis-programming.com/how-to-run-scripts-when-rebooted-startup-on-ubuntu-18-04/
## link to this script placed in /etc/rc.local
#ifconfig | grep "inet" | grep -Po "(?:\d{1,3}\.){3}\d{1,3}" | head -n 1 | /usr/sbin/ssmtp pwesterbaan2@gmail.com
ifconfig | grep "inet" | grep -Po "(?:\d{1,3}\.){3}\d{1,3}" | head -n 1 | /usr/bin/mail pwesterbaan2@gmail.com

## email with attachment
# echo "message" | mail -s "subject" <recipient> -A <file>
