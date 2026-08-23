#!/bin/sh
# Link coverage git hooks when this Flutter app is its own git repository.
# Usage:
#   ./coverage_pipeline/install-git-hooks.sh [app_dir]
# After copying coverage_pipeline/ next to pubspec.yaml, app_dir is optional.
set -eu

pipeline_root="$(CDPATH= cd -- "$(dirname "$0")" && pwd)"
pipeline_parent="$(CDPATH= cd -- "${pipeline_root}/.." && pwd)"

if [ -n "${1:-}" ]; then
  app_root="$(CDPATH= cd -- "$1" && pwd)"
elif [ -f "${pipeline_parent}/pubspec.yaml" ]; then
  app_root="$pipeline_parent"
else
  echo "usage: $0 <app_dir>" >&2
  echo "In the playground, pass the app folder." >&2
  echo "After copying coverage_pipeline/ next to pubspec.yaml, run this script without arguments." >&2
  exit 1
fi

if [ ! -f "${app_root}/pubspec.yaml" ]; then
  echo "install-git-hooks: ${app_root} is not a Flutter app (missing pubspec.yaml)." >&2
  exit 1
fi

git_root="$(git -C "$app_root" rev-parse --show-toplevel 2>/dev/null || true)"

if [ -z "$git_root" ]; then
  echo "install-git-hooks: this folder is not a git repository yet." >&2
  echo "Create a repo (git init), then run this script again." >&2
  exit 1
fi

if [ "$git_root" != "$app_root" ]; then
  echo "install-git-hooks: this app lives inside ${git_root}."
  echo "Coverage is per app. Refresh this badge with:"
  echo "  ${pipeline_root}/update_coverage.sh ${app_root}"
  echo "After you copy this app and coverage_pipeline/ into its own git repo, run this script again."
  exit 0
fi

if [ "$pipeline_parent" != "$app_root" ]; then
  echo "install-git-hooks: copy coverage_pipeline/ next to pubspec.yaml in this repo, then run this script from there." >&2
  exit 1
fi

hooks_dir="${app_root}/.git/hooks"

chmod +x \
  "${pipeline_root}/git-hooks/pre-commit" \
  "${pipeline_root}/git-hooks/pre-push" \
  "${pipeline_root}/update_coverage.sh"

ln -sf ../../coverage_pipeline/git-hooks/pre-commit "${hooks_dir}/pre-commit"
ln -sf ../../coverage_pipeline/git-hooks/pre-push "${hooks_dir}/pre-push"
echo "install-git-hooks: linked pre-commit and pre-push."
