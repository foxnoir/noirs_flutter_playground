#!/bin/sh
# Run tests with coverage for every Flutter app and refresh README badges.
set -eu

repo_root="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

export PATH="${HOME}/.pub-cache/bin:${PATH}"

if ! command -v python3 >/dev/null 2>&1; then
  echo "update_coverage: python3 is required." >&2
  exit 1
fi

found_project=0
failed=0

for pubspec in */pubspec.yaml; do
  [ -f "$pubspec" ] || continue
  found_project=1
  project_dir="$(dirname "$pubspec")"
  echo "update_coverage: testing ${project_dir}…"

  if [ -n "${CI:-}" ] || ! command -v fvm >/dev/null 2>&1 || [ ! -f "${project_dir}/.fvmrc" ]; then
    if ! (cd "$project_dir" && flutter test --coverage); then
      echo "update_coverage: tests failed in ${project_dir}." >&2
      failed=1
      continue
    fi
  else
    if ! (cd "$project_dir" && fvm flutter test --coverage); then
      echo "update_coverage: tests failed in ${project_dir}." >&2
      failed=1
      continue
    fi
  fi

  lcov="${project_dir}/coverage/lcov.info"
  if [ ! -f "$lcov" ]; then
    echo "update_coverage: missing ${lcov}." >&2
    failed=1
    continue
  fi

  python3 "${repo_root}/tool/coverage_badge.py" \
    --lcov "$lcov" \
    --badge "${project_dir}/images/coverage_badge.svg" \
    --card "${project_dir}/images/coverage.svg" \
    --readme "${project_dir}/README.md"
done

if [ "$found_project" -eq 0 ]; then
  echo "update_coverage: no Flutter projects found." >&2
  exit 1
fi

if [ "$failed" -ne 0 ]; then
  exit 1
fi
