#!/bin/sh
# Echo Flutter app directories relative to the playground root, one per line.
set -eu

repo_root="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

for pubspec in */pubspec.yaml app_starters/*/pubspec.yaml; do
  [ -f "$pubspec" ] || continue
  dirname "$pubspec"
done
