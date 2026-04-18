#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
manifest="${repo_root}/nvim/treesitter/sources.tsv"
parser_dir="${repo_root}/nvim/parser"
cache_root="${XDG_CACHE_HOME:-${HOME}/.cache}/dotfiles-treesitter"
abi="${TREE_SITTER_ABI:-15}"

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

mkdir -p "${parser_dir}" "${cache_root}"

download_and_extract() {
  local url="$1"
  local revision="$2"
  local output_dir="$3"
  local repo_name tarball_path tmp_dir extracted dir_rev

  repo_name="${url##*/}"
  repo_name="${repo_name%.git}"
  tarball_path="${cache_root}/${repo_name}-${revision}.tar.gz"
  tmp_dir="${output_dir}.tmp"
  dir_rev="${revision}"
  if [[ "${revision}" =~ ^v[0-9] ]]; then
    dir_rev="${revision#v}"
  fi

  rm -rf "${output_dir}" "${tmp_dir}"

  echo "==> download ${repo_name}@${revision}"
  curl --silent --fail --show-error --location \
    "${url%.git}/archive/${revision}.tar.gz" \
    --output "${tarball_path}"

  mkdir -p "${tmp_dir}"
  tar -xzf "${tarball_path}" -C "${tmp_dir}"

  extracted="${tmp_dir}/${repo_name}-${dir_rev}"
  mv "${extracted}" "${output_dir}"

  rm -rf "${tmp_dir}" "${tarball_path}"
}

while IFS=$'\t' read -r lang url revision location; do
  if [[ -z "${lang}" || "${lang}" == \#* ]]; then
    continue
  fi

  work_dir="${cache_root}/${lang}"
  download_and_extract "${url}" "${revision}" "${work_dir}"

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
  (
    cd "${source_dir}"
    "${tree_sitter_cmd[@]}" build -o "${parser_dir}/${lang}.so"
  )

  rm -rf "${work_dir}"
done < "${manifest}"
