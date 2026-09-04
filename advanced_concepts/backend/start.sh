#!/usr/bin/env bash
set -euo pipefail
cd "$(cd "$(dirname "$0")" && pwd)"

npm install --no-audit --no-fund
npm --prefix functions install --omit=dev --no-audit --no-fund

if lsof -nP -iTCP:8080 -sTCP:LISTEN >/dev/null 2>&1; then
  echo "Port 8080 is busy. A leftover Firestore emulator is still running."
  echo "Kill it, then start again:"
  echo "  kill \$(lsof -t -iTCP:8080 -sTCP:LISTEN)"
  exit 1
fi

echo
echo "API:  http://127.0.0.1:5001/noirs-firebase-lab/europe-west1/api"
echo "UI:   http://127.0.0.1:4000"
echo "Leave this Terminal open. Then run the Flutter app."
echo "Ctrl+C exports Firestore to emulator-data/ (restored on the next start)."
echo

args=(emulators:start --only functions,firestore --export-on-exit=./emulator-data)
if [[ -d emulator-data ]]; then
  args+=(--import=./emulator-data)
fi

exec npx firebase "${args[@]}"
