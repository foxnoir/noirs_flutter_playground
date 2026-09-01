#!/usr/bin/env bash
set -euo pipefail
cd "$(cd "$(dirname "$0")" && pwd)"

npm install
npm --prefix functions install --omit=dev

echo
echo "API:  http://127.0.0.1:5001/noirs-firebase-lab/europe-west1/api"
echo "UI:   http://127.0.0.1:4000"
echo

exec npx firebase emulators:start --only functions,firestore
