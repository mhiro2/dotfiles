#!/usr/bin/env bash
set -eu

KOMPOSE_VERSION="v1.0.0"
curl -L https://github.com/kubernetes-incubator/kompose/releases/download/${KOMPOSE_VERSION}/kompose-linux-amd64 -o /usr/local/bin/kompose
sudo chmod +x /usr/local/bin/kompose
