#!/bin/sh
# Run `flutter test` for one app. On failure print the failing test names
# and a re-run command — compact reporter output is otherwise easy to miss
# in GitLens / Source Control.
# Usage: run_flutter_tests.sh <app_root> <app_label>
set -eu

if [ "${1:-}" = "" ] || [ "${2:-}" = "" ]; then
  echo "usage: $0 <app_root> <app_label>" >&2
  exit 1
fi

app_root="$(CDPATH= cd -- "$1" && pwd)"
app_label=$2

if [ ! -f "${app_root}/pubspec.yaml" ]; then
  echo "run_flutter_tests: ${app_root} is not a Flutter app (missing pubspec.yaml)." >&2
  exit 1
fi

export PATH="${HOME}/.pub-cache/bin:${PATH}"

git_dir="$(git rev-parse --git-dir 2>/dev/null || true)"
if [ -n "${git_dir:-}" ]; then
  log="${git_dir}/pre-push-test.log"
else
  log="${app_root}/pre-push-test.log"
fi

if [ -f "${app_root}/.fvmrc" ] && command -v fvm >/dev/null 2>&1; then
  run_cmd="fvm flutter test"
else
  run_cmd="flutter test"
fi

echo "pre-push: testing ${app_label}…"

set +e
(cd "$app_root" && $run_cmd --reporter compact) >"$log" 2>&1
status=$?
set -e

if [ "$status" -eq 0 ]; then
  echo "pre-push: ${app_label} OK"
  exit 0
fi

normalized="${log}.lines"
tr '\r' '\n' <"$log" >"$normalized"

echo "" >&2
echo "error: pre-push blocked — tests failed in ${app_label}" >&2
echo "" >&2
echo "Failing tests:" >&2

found=0
while IFS= read -r line || [ -n "${line:-}" ]; do
  case "$line" in
    *'[E]')
      case "$line" in
        */test/*)
          rest=${line##*/test/}
          echo "  ✗ test/${rest% \[E]}" >&2
          ;;
        *)
          echo "  ✗ ${line% \[E]}" >&2
          ;;
      esac
      found=1
      ;;
  esac
done <"$normalized"

if [ "$found" -eq 0 ]; then
  echo "  (could not parse names — open the log)" >&2
fi

echo "" >&2
echo "Re-run:" >&2
echo "  cd ${app_label} && ${run_cmd}" >&2
echo "" >&2
echo "Full log: ${log}" >&2
echo "" >&2

rm -f "$normalized"
exit 1
