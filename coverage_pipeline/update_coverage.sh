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

# Do not pass --reporter compact and do not redirect stdout.
# On GitHub Actions, `flutter test` defaults to the `github` reporter, which
# writes ::error annotations with the failing test name. Compact + a log file
# hid that, so the job only showed "Process completed with exit code 1."
if [ -n "${CI:-}" ] || ! command -v fvm >/dev/null 2>&1 || [ ! -f "${app_root}/.fvmrc" ]; then
  run_flutter() { flutter "$@"; }
else
  run_flutter() { fvm flutter "$@"; }
fi

# pub.dev sometimes returns 401 ("authorization failed") on GitHub runners.
# flutter test then never starts. Retry pub get before treating it as a test fail.
attempt=1
pub_status=1
while [ "$attempt" -le 3 ]; do
  echo "update_coverage: pub get (attempt ${attempt}/3)…"
  set +e
  run_flutter pub get
  pub_status=$?
  set -e
  if [ "$pub_status" -eq 0 ]; then
    break
  fi
  echo "update_coverage: pub get exited ${pub_status}, retrying…" >&2
  attempt=$((attempt + 1))
  sleep 8
done

if [ "$pub_status" -ne 0 ]; then
  echo "update_coverage: pub get failed in ${app_root} after 3 attempts." >&2
  if [ -n "${GITHUB_ACTIONS:-}" ]; then
    echo "::error::pub get failed in ${app_root##*/} (pub.dev). Not a failing test." >&2
  fi
  exit "$pub_status"
fi

set +e
run_flutter test --coverage
status=$?
set -e

if [ "$status" -ne 0 ]; then
  echo "update_coverage: tests failed in ${app_root}" >&2
  if [ -n "${GITHUB_ACTIONS:-}" ]; then
    echo "::error::Tests failed in ${app_root##*/}. Scroll the test log above for the failing name." >&2
  fi
  exit "$status"
fi

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
