#!/usr/bin/env bash
set -eu

CONTAINER_DIFF_VERSION="v0.2.0"

case "${OSTYPE}" in
  darwin*)
    OSNAME=darwin
    ;;
  linux*)
    OSNAME=linux
    ;;
  *)
    exit 1
esac

curl -L https://storage.googleapis.com/container-diff/${CONTAINER_DIFF_VERSION}/container-diff-amd64-${OSNAME} \
     -o /usr/local/bin/container-diff
sudo chmod +x /usr/local/bin/container-diff
