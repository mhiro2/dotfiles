#!/usr/bin/env bash

readonly COLOR_INFO=$'\033[1;34m'
readonly COLOR_SUCCESS=$'\033[1;32m'
readonly COLOR_SKIP=$'\033[1;33m'
readonly COLOR_RESET=$'\033[0m'

info() {
  printf '%s==> %s%s\n' "${COLOR_INFO}" "$*" "${COLOR_RESET}"
}

step() {
  printf '%s   -> %s%s\n' "${COLOR_INFO}" "$*" "${COLOR_RESET}"
}

success() {
  printf '%s✔ %s%s\n' "${COLOR_SUCCESS}" "$*" "${COLOR_RESET}"
}

skip() {
  printf '%s✔ %s%s\n' "${COLOR_SKIP}" "$*" "${COLOR_RESET}"
}

is_macos() {
  [[ "$(uname)" == "Darwin" ]]
}
