#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 OLD_DATE NEW_DATE SLUG" >&2
  exit 1
fi

old_date="$1"
new_date="$2"
slug="$3"

old_dir="content/post/${old_date}-${slug}"
new_dir="content/post/${new_date}-${slug}"

if [ ! -d "$old_dir" ]; then
  echo "Post directory not found: $old_dir" >&2
  exit 1
fi

if [ -e "$new_dir" ]; then
  echo "Target directory already exists: $new_dir" >&2
  exit 1
fi

mv "$old_dir" "$new_dir"

for file in "$new_dir/index.Rmd" "$new_dir/index.html"; do
  if [ -f "$file" ]; then
    perl -0pi -e "s/date: '\\Q$old_date\\E'/date: '$new_date'/" "$file"
  fi
done

echo "Moved $old_dir -> $new_dir"
