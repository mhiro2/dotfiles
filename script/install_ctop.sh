#!/usr/bin/env bash
set -eu

CTOP_VERSION=0.4.1

if [ -x "/usr/lcoal/bin/ctop" ]; then
  if [ $(ctop -v | grep -o '[0-9]\.[0-9]\(\.[0-9]*\)*') = "${CTOP_VERSION}" ]; then
    echo "ctop already installed"
    exit 0
  fi
fi

wget https://github.com/bcicen/ctop/releases/download/v${CTOP_VERSION}/ctop-${CTOP_VERSION}-linux-amd64 -O /tmp/ctop
sudo install -o root -g root -m 0644 /tmp/ctop /usr/local/bin/ctop
