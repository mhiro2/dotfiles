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

# NONINTERACTIVE=1 だと installer が sudo -n -v でチェックするため、
# 事前に sudo credential をキャッシュしておく必要がある。
info "sudo パスワードをキャッシュします（Homebrew installer が要求するため）"
sudo -v

# Homebrew のインストールには時間がかかるため、sudo timestamp を維持し続ける。
( while true; do sudo -n true; sleep 60; kill -0 "$$" 2>/dev/null || exit; done ) &
readonly SUDO_KEEPALIVE_PID=$!
trap 'kill "${SUDO_KEEPALIVE_PID}" 2>/dev/null || true' EXIT

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

success "Homebrew のインストールが完了しました"
