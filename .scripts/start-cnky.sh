#!/bin/bash
pkill conky
conky -p 1 -c ~/.scripts/conkyrc &
exit
