#!/usr/bin/env bash
set -euo pipefail

REPO="yuru7/moralerspace"
FAMILY="Neon"
FONTS_DIR="${HOME}/Library/Fonts"
STATE_DIR="${XDG_CACHE_HOME:-${HOME}/.cache}/dotfiles"
MARKER="${STATE_DIR}/moralerspace.version"

if [[ "$(uname)" != "Darwin" ]]; then
  echo "macOS 以外のためスキップします"
  exit 0
fi

latest_tag=$(curl -fsSLI -o /dev/null -w '%{url_effective}' \
  "https://github.com/${REPO}/releases/latest" | awk -F'/' '{print $NF}')

if [[ -z "${latest_tag}" || "${latest_tag}" == "latest" ]]; then
  echo "最新バージョンの取得に失敗しました" >&2
  exit 1
fi

if [[ -f "${MARKER}" ]] && [[ "$(cat "${MARKER}")" == "${latest_tag}" ]]; then
  echo "Moralerspace ${FAMILY} ${latest_tag} は既にインストール済みのためスキップします"
  exit 0
fi

zip_name="Moralerspace_${latest_tag}.zip"
download_url="https://github.com/${REPO}/releases/download/${latest_tag}/${zip_name}"
tmpdir=$(mktemp -d)
trap 'rm -rf "${tmpdir}"' EXIT

echo "Moralerspace ${latest_tag} をダウンロードします"
curl -fsSL -o "${tmpdir}/${zip_name}" "${download_url}"
unzip -q "${tmpdir}/${zip_name}" -d "${tmpdir}"

mkdir -p "${FONTS_DIR}" "${STATE_DIR}"
find "${tmpdir}" -type f -name "Moralerspace${FAMILY}-*.ttf" -exec cp -f {} "${FONTS_DIR}/" \;

echo "${latest_tag}" > "${MARKER}"
echo "Moralerspace ${FAMILY} ${latest_tag} のインストールが完了しました"
