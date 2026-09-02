#!/bin/sh
# Run tests with coverage for one Flutter app and refresh README badges.
# Usage:
#   ./coverage_pipeline/update_coverage.sh [app_dir]
# app_dir defaults to the current directory if it contains pubspec.yaml.
set -eu

pipeline_root="$(CDPATH= cd -- "$(dirname "$0")" && pwd)"

if [ -n "${1:-}" ]; then
  app_root="$1"
elif [ -f pubspec.yaml ]; then
  app_root="$PWD"
else
  echo "usage: $0 <app_dir>" >&2
  echo "Pass a Flutter app directory, or run from a directory that contains pubspec.yaml." >&2
  exit 1
fi

app_root="$(CDPATH= cd -- "$app_root" && pwd)"

if [ ! -f "${app_root}/pubspec.yaml" ]; then
  echo "update_coverage: ${app_root} is not a Flutter app (missing pubspec.yaml)." >&2
  exit 1
fi

cd "$app_root"

export PATH="${HOME}/.pub-cache/bin:${PATH}"

if ! command -v python3 >/dev/null 2>&1; then
  echo "update_coverage: python3 is required." >&2
  exit 1
fi

echo "update_coverage: testing ${app_root}…"

if [ -n "${CI:-}" ] || ! command -v fvm >/dev/null 2>&1 || [ ! -f "${app_root}/.fvmrc" ]; then
  run_cmd="flutter test --coverage"
else
  run_cmd="fvm flutter test --coverage"
fi

log="${app_root}/.update_coverage_test.log"
set +e
# Compact reporter uses \r; keep a line-based copy for [E] names.
(cd "$app_root" && $run_cmd --reporter compact) >"$log" 2>&1
status=$?
set -e
normalized="${log}.lines"
tr '\r' '\n' <"$log" | tee "$normalized"

if [ "$status" -ne 0 ]; then
  echo "update_coverage: tests failed in ${app_root}" >&2
  echo "Failing tests:" >&2
  found=0
  while IFS= read -r line || [ -n "${line:-}" ]; do
    case "$line" in
      *'[E]')
        echo "  ✗ ${line% \[E]}" >&2
        found=1
        ;;
    esac
  done <"$normalized"
  if [ "$found" -eq 0 ]; then
    echo "  (could not parse names — see log above)" >&2
  fi
  rm -f "$log" "$normalized"
  exit "$status"
fi
rm -f "$log" "$normalized"

lcov="${app_root}/coverage/lcov.info"
if [ ! -f "$lcov" ]; then
  echo "update_coverage: missing ${lcov}." >&2
  exit 1
fi

python3 "${pipeline_root}/coverage_badge.py" \
  --lcov "$lcov" \
  --badge "${app_root}/assets/coverage/badge.svg" \
  --card "${app_root}/assets/coverage/card.svg" \
  --readme "${app_root}/README.md"
