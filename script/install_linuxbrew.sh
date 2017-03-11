#!/usr/bin/env bash
set -eu

command -v ruby > /dev/null && \
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
