#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
# shellcheck source=scripts/common.sh
source "${SCRIPT_DIR}/common.sh"

if ! is_macos; then
  skip "macOS 以外のため Homebrew インストールをスキップします"
  exit 0
fi

if command -v brew >/dev/null 2>&1; then
  skip "Homebrew は既にインストール済みのためスキップします"
  exit 0
fi

info "Homebrew をインストールします"
install_for_arch() {
  local -r arch_name="$1"
  NONINTERACTIVE=1 arch "${arch_name}" /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

if [[ "$(uname -m)" == "arm64" ]]; then
  install_for_arch -arm64
  if arch -x86_64 /usr/bin/true >/dev/null 2>&1; then
    install_for_arch -x86_64
  else
    skip "Rosetta が利用できないため x86_64 Homebrew インストールをスキップします"
  fi
else
  install_for_arch -x86_64
fi

success "Homebrew のインストールが完了しました"
