#!/bin/bash
pkill conky
conky -p 1 -c ~/.conkyrc &
exit
