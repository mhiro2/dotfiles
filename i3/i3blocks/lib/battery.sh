#!/usr/bin/env bash

set -eu

ACPI_OUT=$(acpitool -b)

POWER_STATE=$(echo $ACPI_OUT | awk '$0 = substr($4, 0, length($4)-1)')
BATTERY_REMAIN=$(echo $ACPI_OUT | awk '$0 = $5' | awk -F'.' '$0=$1')

NOTIFIED=0

IFS=':' read -r state remain notified < ~/.cache/i3blocks-battery

case ${POWER_STATE} in
  [Cc]harging)
    echo -en "\uf1e6 "
    # TODO: notify-send -> dunst
  ;;
  [Dd]ischarging)
    if ((1<=${BATTERY_REMAIN} && ${BATTERY_REMAIN}<=5)); then
      echo -en "\uf244 "
    elif ((6<=${BATTERY_REMAIN} && ${BATTERY_REMAIN}<=25)); then
      echo -en "\uf243 "
    elif ((26<=${BATTERY_REMAIN} && ${BATTERY_REMAIN}<=50)); then
      echo -en "\uf242 "
    elif ((51<=${BATTERY_REMAIN} && ${BATTERY_REMAIN}<=80)); then
      echo -en "\uf241 "
    elif ((81<=${BATTERY_REMAIN} && ${BATTERY_REMAIN}<=100)); then
      echo -en "\uf240 "
    else
      echo -en "\uf244 "
    fi

    # TODO: notify-send -> dunst
  ;;
  Full|[Cc]harged)
    echo -en "\uf1e6 "
  ;;
esac

echo "${POWER_STATE}:${BATTERY_REMAIN}:${NOTIFIED}" > ~/.cache/i3blocks-battery
echo "${BATTERY_REMAIN}%"

