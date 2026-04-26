#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
# shellcheck source=scripts/common.sh
source "${SCRIPT_DIR}/common.sh"

if command -v mise >/dev/null 2>&1; then
  skip "mise は既にインストール済みのためスキップします"
  exit 0
fi

info "mise をインストールします"
curl -s https://mise.run | sh

success "mise のインストールが完了しました"
