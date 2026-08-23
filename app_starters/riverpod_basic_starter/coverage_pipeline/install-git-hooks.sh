#!/bin/sh
set -eu

app_root="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
git_root="$(git -C "$app_root" rev-parse --show-toplevel 2>/dev/null || true)"

if [ -z "$git_root" ]; then
  echo "install-git-hooks: this folder is not a git repository yet." >&2
  echo "Create a repo (git init), then run this script again." >&2
  exit 1
fi

if [ "$git_root" != "$app_root" ]; then
  echo "install-git-hooks: this app lives inside ${git_root}."
  echo "Coverage is per app. Refresh this badge with:"
  echo "  ${app_root}/coverage_pipeline/update_coverage.sh"
  echo "After you copy this folder into its own git repo, run this script again."
  exit 0
fi

hooks_dir="${app_root}/.git/hooks"

chmod +x \
  "${app_root}/coverage_pipeline/git-hooks/pre-commit" \
  "${app_root}/coverage_pipeline/git-hooks/pre-push" \
  "${app_root}/coverage_pipeline/update_coverage.sh"

ln -sf ../../coverage_pipeline/git-hooks/pre-commit "${hooks_dir}/pre-commit"
ln -sf ../../coverage_pipeline/git-hooks/pre-push "${hooks_dir}/pre-push"
echo "install-git-hooks: linked pre-commit and pre-push."
