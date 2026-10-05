#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if command -v mamba >/dev/null 2>&1; then
  env_manager="$(command -v mamba)"
elif command -v conda >/dev/null 2>&1; then
  env_manager="$(command -v conda)"
elif [ -x "$HOME/.local/opt/miniforge3/bin/mamba" ]; then
  env_manager="$HOME/.local/opt/miniforge3/bin/mamba"
else
  echo 'Install Miniforge (Conda/Mamba), then run make env-setup again.' >&2
  exit 1
fi

if [ -d "$root_dir/.conda/conda-meta" ]; then
  echo 'Project Conda environment already exists.'
# The explicit lock recreates the tested Linux environment without re-solving.
elif [ "$(uname -s)" = Linux ] && [ "$(uname -m)" = x86_64 ] && [ -f "$root_dir/environment-linux-64.lock" ]; then
  "$env_manager" create --yes --prefix "$root_dir/.conda" --file "$root_dir/environment-linux-64.lock"
else
  "$env_manager" env create --yes --prefix "$root_dir/.conda" --file "$root_dir/environment.yml"
fi

mkdir -p "$root_dir/.r-library"
bash "$root_dir/scripts/with-project-env.sh" Rscript "$root_dir/scripts/install-r-extras.R"
