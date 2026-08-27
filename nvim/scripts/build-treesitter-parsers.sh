#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
manifest="${repo_root}/nvim/treesitter/sources.tsv"
parser_dir="${repo_root}/nvim/parser"
cache_root="${XDG_CACHE_HOME:-${HOME}/.cache}/dotfiles-treesitter"
tarball_cache="${cache_root}/tarballs"
marker_dir="${cache_root}/rev"
abi="${TREE_SITTER_ABI:-15}"
force="${TREESITTER_FORCE:-0}"

if [[ "${1:-}" == "--force" ]]; then
  force=1
fi

if [[ ! -f "${manifest}" ]]; then
  echo "manifest not found: ${manifest}" >&2
  exit 1
fi

if command -v tree-sitter >/dev/null 2>&1; then
  tree_sitter_cmd=(tree-sitter)
elif command -v mise >/dev/null 2>&1; then
  tree_sitter_cmd=(mise exec -- tree-sitter)
else
  echo "tree-sitter command not found" >&2
  exit 1
fi

for cmd in curl tar; do
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "${cmd} command not found" >&2
    exit 1
  fi
done

mkdir -p "${parser_dir}" "${cache_root}" "${tarball_cache}" "${marker_dir}"

rm -f "${parser_dir}"/*.rev

# tarball は revision 単位でキャッシュし、再取得を避ける。
fetch_tarball() {
  local url="$1"
  local revision="$2"
  local repo_name="$3"
  local tarball_path="$4"
  local tmp_path

  if [[ -f "${tarball_path}" ]]; then
    echo "==> cached tarball ${repo_name}@${revision}"
    return 0
  fi

  echo "==> download ${repo_name}@${revision}"
  tmp_path="${tarball_path}.part"
  curl --silent --fail --show-error --location \
    "${url%.git}/archive/${revision}.tar.gz" \
    --output "${tmp_path}"
  mv "${tmp_path}" "${tarball_path}"
}

extract_tarball() {
  local revision="$1"
  local repo_name="$2"
  local tarball_path="$3"
  local output_dir="$4"
  local tmp_dir="${output_dir}.tmp"
  local dir_rev="${revision}"

  if [[ "${revision}" =~ ^v[0-9] ]]; then
    dir_rev="${revision#v}"
  fi

  rm -rf "${output_dir}" "${tmp_dir}"
  mkdir -p "${tmp_dir}"
  tar -xzf "${tarball_path}" -C "${tmp_dir}"
  mv "${tmp_dir}/${repo_name}-${dir_rev}" "${output_dir}"
  rm -rf "${tmp_dir}"
}

built=0
skipped=0

while IFS=$'\t' read -r lang url revision location; do
  if [[ -z "${lang}" || "${lang}" == \#* ]]; then
    continue
  fi

  parser_so="${parser_dir}/${lang}.so"
  marker="${marker_dir}/${lang}.rev"
  # 生成物が入力 (revision + ABI) と一致していれば再生成しない。
  stamp="${revision} abi=${abi}"

  if [[ "${force}" != "1" && -f "${parser_so}" && -f "${marker}" ]] &&
    [[ "$(cat "${marker}")" == "${stamp}" ]]; then
    echo "==> up-to-date ${lang}@${revision}"
    skipped=$((skipped + 1))
    continue
  fi

  repo_name="${url##*/}"
  repo_name="${repo_name%.git}"
  tarball_path="${tarball_cache}/${repo_name}-${revision}.tar.gz"
  work_dir="${cache_root}/${lang}"

  fetch_tarball "${url}" "${revision}" "${repo_name}" "${tarball_path}"
  extract_tarball "${revision}" "${repo_name}" "${tarball_path}" "${work_dir}"

  source_dir="${work_dir}"
  if [[ "${location}" != "." ]]; then
    source_dir="${work_dir}/${location}"
  fi

  if [[ ! -f "${source_dir}/src/parser.c" ]]; then
    echo "==> generate ${lang}"
    if [[ -f "${source_dir}/src/grammar.json" ]]; then
      (
        cd "${source_dir}"
        TREE_SITTER_JS_RUNTIME=native "${tree_sitter_cmd[@]}" generate --abi "${abi}" src/grammar.json
      )
    else
      (
        cd "${source_dir}"
        TREE_SITTER_JS_RUNTIME=native "${tree_sitter_cmd[@]}" generate --abi "${abi}"
      )
    fi
  fi

  echo "==> build ${lang}"
  # ビルド失敗時に marker だけ残らないよう、先に無効化する。
  rm -f "${marker}"
  (
    cd "${source_dir}"
    "${tree_sitter_cmd[@]}" build -o "${parser_so}"
  )
  echo "${stamp}" >| "${marker}"
  built=$((built + 1))

  rm -rf "${work_dir}"
done < "${manifest}"

echo "==> done (built: ${built}, up-to-date: ${skipped})"
