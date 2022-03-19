#!/bin/env bash

# Screen brightness controller

b=$(cat /sys/class/backlight/intel_backlight/brightness)

sum=$(( $1 + $b))

echo "$sum" | sudo tee -a "/sys/class/backlight/intel_backlight/brightness"
