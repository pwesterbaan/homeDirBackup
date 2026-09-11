#!/usr/bin/env bash

# run when touchpad fails after resume
sudo rmmod psmouse
sudo modprobe psmouse
