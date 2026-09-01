#!/usr/bin/env bash
set -euo pipefail
cd "$(cd "$(dirname "$0")" && pwd)"

npm install
npm --prefix functions install --omit=dev

if ! npx firebase projects:list --non-interactive >/dev/null 2>&1; then
  npx firebase login
fi

PROJECT_ID="${FIREBASE_PROJECT_ID:-$(node -p "require('./.firebaserc').projects.default")}"

if ! npx firebase use "$PROJECT_ID" --non-interactive >/dev/null 2>&1; then
  echo "Creating Firebase project: $PROJECT_ID"
  if ! npx firebase projects:create "$PROJECT_ID" --display-name "Noir Firebase Lab"; then
    echo "That project id is taken. Re-run with a unique id:" >&2
    echo "  FIREBASE_PROJECT_ID=noirs-lab-yourname ./deploy.sh" >&2
    exit 1
  fi
  npx firebase use "$PROJECT_ID"
fi

# Keep .firebaserc in sync when FIREBASE_PROJECT_ID is set.
node -e "
const fs = require('fs');
const path = '.firebaserc';
const rc = JSON.parse(fs.readFileSync(path, 'utf8'));
rc.projects.default = process.argv[1];
fs.writeFileSync(path, JSON.stringify(rc, null, 2) + '\n');
" "$PROJECT_ID"

echo
echo "Cloud Functions need the Blaze plan (pay-as-you-go; this lab stays in the free quota)."
echo

npx firebase deploy --only functions,firestore
