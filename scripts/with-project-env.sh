#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
project_env="$root_dir/.conda"

if [ ! -x "$project_env/bin/Rscript" ]; then
  echo 'Project R environment not found. Run make env-setup first.' >&2
  exit 1
fi

# Select this project's interpreter and libraries for this process only.
export PATH="$project_env/bin:$PATH"
export R_LIBS="$root_dir/.r-library"
export R_LIBS_USER="$root_dir/.r-library"
export R_LIBS_SITE="$project_env/lib/R/library"
export R_ENVIRON_USER=/dev/null
export R_PROFILE_USER="$root_dir/.Rprofile"
export QUARTO_R="$project_env/bin/R"
export RSTUDIO_WHICH_R="$project_env/bin/R"

exec "$@"
