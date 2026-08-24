#!/bin/sh
# Refresh coverage images for every playground app listed in playground_apps.
# Usage (from playground root):
#   ./coverage_pipeline/update_all.sh
set -eu

pipeline_root="$(CDPATH= cd -- "$(dirname "$0")" && pwd)"
playground_root="$(CDPATH= cd -- "${pipeline_root}/.." && pwd)"
apps_file="${pipeline_root}/playground_apps"

if [ ! -f "$apps_file" ]; then
  echo "update_all: missing ${apps_file}." >&2
  exit 1
fi

while IFS= read -r app || [ -n "${app:-}" ]; do
  case "$app" in
    '' | \#*) continue ;;
  esac
  "${pipeline_root}/update_coverage.sh" "${playground_root}/${app}"
done <"$apps_file"
