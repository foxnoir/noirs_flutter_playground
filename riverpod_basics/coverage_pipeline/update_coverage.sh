#!/bin/sh
# Run tests with coverage for this app and refresh README badges.
set -eu

app_root="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
cd "$app_root"

export PATH="${HOME}/.pub-cache/bin:${PATH}"

if ! command -v python3 >/dev/null 2>&1; then
  echo "update_coverage: python3 is required." >&2
  exit 1
fi

echo "update_coverage: testing ${app_root}…"

if [ -n "${CI:-}" ] || ! command -v fvm >/dev/null 2>&1 || [ ! -f "${app_root}/.fvmrc" ]; then
  flutter test --coverage
else
  fvm flutter test --coverage
fi

lcov="${app_root}/coverage/lcov.info"
if [ ! -f "$lcov" ]; then
  echo "update_coverage: missing ${lcov}." >&2
  exit 1
fi

python3 "${app_root}/coverage_pipeline/coverage_badge.py" \
  --lcov "$lcov" \
  --badge "${app_root}/assets/coverage/badge.svg" \
  --card "${app_root}/assets/coverage/card.svg" \
  --readme "${app_root}/README.md"
