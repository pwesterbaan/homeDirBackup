#!/bin/bash
pkill conky
conky -dq -p 10 -u 1 -c ~/.scripts/conkyrc &
exit
