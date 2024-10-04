#!/bin/bash

maxLength=$(tail -2 ~/.config/pianobar/nowplaying | wc -L)

printf "%-${maxLength}s" "$(head -$1 ~/.config/pianobar/nowplaying | tail -n 1)"
