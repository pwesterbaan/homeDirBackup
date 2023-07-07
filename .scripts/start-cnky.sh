#!/bin/bash
pkill conky
conky -dq -p 10 -c ~/.scripts/conkyrc &
exit
