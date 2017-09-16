#!/usr/bin/env bash

set -eu

VOLUME=$(pulseaudio-ctl full-status | awk '$0=$1')
MUTE=$(pulseaudio-ctl full-status | awk '$0=$2')

if [ ${MUTE} = 'yes' ]; then
  echo -en '\uf026 (muted)'
  exit
fi

if ((1<=${VOLUME} && ${VOLUME}<=29)); then
  echo -en "\uf027 ${VOLUME}%"
elif ((30<=${VOLUME})); then
  echo -en "\uf028 ${VOLUME}%"
else
  echo -en '\uf026 0%'
fi

