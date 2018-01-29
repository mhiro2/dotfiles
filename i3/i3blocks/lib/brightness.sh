#!/usr/bin/env bash

set -eu

MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)
BRIGHTNESS=$(echo "scale=2; $(cat /sys/class/backlight/intel_backlight/brightness)/${MAX_BRIGHTNESS}" | bc -l)

echo -en "\uf0eb${BRIGHTNESS/./}%"

