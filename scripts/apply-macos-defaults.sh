#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
# shellcheck source=scripts/common.sh
source "${SCRIPT_DIR}/common.sh"

if ! is_macos; then
  skip "macOS 以外のため defaults の適用をスキップします"
  exit 0
fi

info "macOS の defaults を適用します"

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder _FXShowPosixPathInWindowTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Global
defaults write -g AppleShowAllExtensions -bool true

# Keyboard repeat
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 2

# 長押しでアクセント記号メニューを出さず、キーリピートを有効化
defaults write -g ApplePressAndHoldEnabled -bool false

# テキスト自動置換（コードを壊す系）を無効化
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

killall Finder >/dev/null 2>&1 || true

success "macOS の defaults を適用しました（キーリピート系はログアウト後に反映）"
