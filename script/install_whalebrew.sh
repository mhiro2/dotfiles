#!/usr/bin/env bash
set -eu

WHALEBREW_VERSION=0.0.4
sudo curl -L "https://github.com/bfirsh/whalebrew/releases/download/${WHALEBREW_VERSION}/whalebrew-$(uname -s)-$(uname -m)" -o /usr/local/bin/whalebrew
sudo chmod +x /usr/local/bin/whalebrew
