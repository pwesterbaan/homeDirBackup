#!/bin/bash
pkill conky
conky -dq -p 1 -c ~/.scripts/conkyrc &
exit
