#!/bin/sh
set -eu

repo_root="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
hooks_dir="${repo_root}/.git/hooks"

if [ ! -d "$hooks_dir" ]; then
  echo "install-git-hooks: ${hooks_dir} not found." >&2
  exit 1
fi

chmod +x \
  "${repo_root}/tool/git-hooks/pre-commit" \
  "${repo_root}/tool/git-hooks/pre-push" \
  "${repo_root}/tool/update_coverage.sh" \
  "${repo_root}/tool/flutter_apps.sh"

ln -sf ../../tool/git-hooks/pre-commit "${hooks_dir}/pre-commit"
ln -sf ../../tool/git-hooks/pre-push "${hooks_dir}/pre-push"
echo "install-git-hooks: linked pre-commit and pre-push."
