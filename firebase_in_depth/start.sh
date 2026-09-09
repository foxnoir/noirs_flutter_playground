#!/usr/bin/env bash
set -euo pipefail
cd "$(cd "$(dirname "$0")" && pwd)"

if lsof -nP -iTCP:8080 -sTCP:LISTEN >/dev/null 2>&1; then
  echo "Port 8080 is busy. A leftover Firestore emulator is still running."
  echo "Kill it, then start again:"
  echo "  kill \$(lsof -t -iTCP:8080 -sTCP:LISTEN)"
  exit 1
fi

echo
echo "Firestore: 127.0.0.1:8080"
echo "UI:        http://127.0.0.1:4000"
echo "Leave this Terminal open. Then run Flutter with"
echo "  --dart-define=USE_FIREBASE_EMULATOR=true"
echo "or the launch config Firebase in Depth (emulator)."
echo "Ctrl+C exports Firestore to emulator-data/ (restored on the next start)."
echo

(
  for _ in $(seq 1 40); do
    if curl -sf http://127.0.0.1:4000 >/dev/null 2>&1; then
      dart run tool/seed_emulator.dart
      exit 0
    fi
    sleep 1
  done
  echo "Timed out waiting for the emulator UI on 4000."
) &

args=(emulators:start --only firestore --export-on-exit=./emulator-data)
if [[ -d emulator-data ]]; then
  args+=(--import=./emulator-data)
fi

exec npx firebase-tools@13.35.1 "${args[@]}"
