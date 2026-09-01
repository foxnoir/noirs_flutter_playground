#!/usr/bin/env bash
# Hit the local emulator API. Start ./start.sh first.
set -euo pipefail

BASE="${BASE_URL:-http://127.0.0.1:5001/noirs-firebase-lab/europe-west1/api}"

echo "GET $BASE/health"
curl -sS "$BASE/health"
echo

echo "GET $BASE/notes"
curl -sS "$BASE/notes"
echo

echo "POST $BASE/notes"
CREATED="$(curl -sS -X POST "$BASE/notes" \
  -H "Content-Type: application/json" \
  -d '{"title":"From curl","body":"Created by examples/curl.sh"}')"
echo "$CREATED"
ID="$(node -e "console.log(JSON.parse(process.argv[1]).id)" "$CREATED")"
echo

echo "GET $BASE/notes/$ID"
curl -sS "$BASE/notes/$ID"
echo

echo "GET missing → 404"
curl -sS -o /tmp/firebase_lab_missing.json -w "HTTP %{http_code}\n" "$BASE/notes/does-not-exist"
cat /tmp/firebase_lab_missing.json
echo
