#!/usr/bin/env bash
set -eu

WHALEBREW_VERSION=0.0.4
sudo curl -L "https://github.com/bfirsh/whalebrew/releases/download/0.0.4/${WHALEBREW_VERSION}-$(uname -s)-$(uname -m)" -o /usr/local/bin/whalebrew
sudo chmod +x /usr/local/bin/whalebrew
