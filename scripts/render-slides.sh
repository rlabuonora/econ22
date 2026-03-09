#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
slides_dir="$root_dir/slides"
output_root="$root_dir/static/slides"
cache_root="${TMPDIR:-/tmp}/econ22-quarto-cache"
theme_fonts_dir="$root_dir/themes/hugo-lithium/static/fonts"

if ! command -v quarto >/dev/null 2>&1; then
  echo "quarto not found. Install Quarto so slide decks can be rendered." >&2
  exit 1
fi

mkdir -p "$output_root"
mkdir -p "$cache_root"

# Keep Quarto/Deno caches in a writable location.
export XDG_CACHE_HOME="$cache_root"
export DENO_DIR="$cache_root/deno"

found=0

while IFS= read -r qmd; do
  found=1
  slug="$(basename "$(dirname "$qmd")")"
  out_dir="$output_root/$slug"

  rm -rf "$out_dir"
  mkdir -p "$out_dir"

  quarto render "$qmd" --to revealjs --output-dir "$out_dir"
  if [ -d "$theme_fonts_dir" ]; then
    mkdir -p "$out_dir/fonts"
    cp "$theme_fonts_dir"/* "$out_dir/fonts/"
  fi
  echo "Rendered $slug -> static/slides/$slug/"
done < <(find "$slides_dir" -mindepth 2 -maxdepth 2 -name 'index.qmd' | sort)

if [ "$found" -eq 0 ]; then
  echo "No slide decks found under slides/" >&2
fi
