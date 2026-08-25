#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
# shellcheck source=scripts/common.sh
source "${SCRIPT_DIR}/common.sh"

readonly installer_url="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

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

tmpdir="$(mktemp -d)"
readonly tmpdir
trap 'kill "${SUDO_KEEPALIVE_PID}" 2>/dev/null || true; rm -rf "${tmpdir}"' EXIT

readonly installer="${tmpdir}/install.sh"
step "installer を取得します"
if ! curl -fsSL "${installer_url}" --output "${installer}"; then
  echo "Homebrew installer の取得に失敗しました: ${installer_url}" >&2
  exit 1
fi

if [[ ! -s "${installer}" ]]; then
  echo "Homebrew installer が空です: ${installer_url}" >&2
  exit 1
fi

NONINTERACTIVE=1 /bin/bash "${installer}"

brew_path=""
for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [[ -x "${candidate}" ]]; then
    brew_path="${candidate}"
    break
  fi
done
readonly brew_path

if [[ -z "${brew_path}" ]]; then
  echo "brew が見つかりません。Homebrew のインストールに失敗しました" >&2
  exit 1
fi

if ! "${brew_path}" --version >/dev/null 2>&1; then
  echo "brew が実行できません: ${brew_path}" >&2
  exit 1
fi

success "Homebrew のインストールが完了しました (${brew_path})"
