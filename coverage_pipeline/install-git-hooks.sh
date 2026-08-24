#!/bin/sh
# Link coverage git hooks.
# Playground (this repo): hooks refresh every app in playground_apps.
# Copied-out app: copy coverage_pipeline/ next to pubspec.yaml, then run this
# script with no arguments.
# Usage:
#   ./coverage_pipeline/install-git-hooks.sh
#   ./coverage_pipeline/install-git-hooks.sh [app_dir]
set -eu

pipeline_root="$(CDPATH= cd -- "$(dirname "$0")" && pwd)"
pipeline_parent="$(CDPATH= cd -- "${pipeline_root}/.." && pwd)"

git_root="$(git -C "$pipeline_parent" rev-parse --show-toplevel 2>/dev/null || true)"

install_playground_hooks() {
  hooks_dir="${1}/.git/hooks"
  chmod +x \
    "${pipeline_root}/git-hooks/playground-pre-commit" \
    "${pipeline_root}/git-hooks/playground-pre-push" \
    "${pipeline_root}/update_all.sh" \
    "${pipeline_root}/update_coverage.sh"
  ln -sf ../../coverage_pipeline/git-hooks/playground-pre-commit "${hooks_dir}/pre-commit"
  ln -sf ../../coverage_pipeline/git-hooks/playground-pre-push "${hooks_dir}/pre-push"
  echo "install-git-hooks: playground pre-commit and pre-push linked."
}

install_app_hooks() {
  app_root=$1
  hooks_dir="${app_root}/.git/hooks"
  chmod +x \
    "${pipeline_root}/git-hooks/pre-commit" \
    "${pipeline_root}/git-hooks/pre-push" \
    "${pipeline_root}/update_coverage.sh"
  ln -sf ../../coverage_pipeline/git-hooks/pre-commit "${hooks_dir}/pre-commit"
  ln -sf ../../coverage_pipeline/git-hooks/pre-push "${hooks_dir}/pre-push"
  echo "install-git-hooks: linked pre-commit and pre-push."
}

# Playground: coverage_pipeline at git root, no pubspec.yaml at git root.
if [ -n "$git_root" ] && [ -d "${git_root}/coverage_pipeline" ] && [ ! -f "${git_root}/pubspec.yaml" ]; then
  install_playground_hooks "$git_root"
  exit 0
fi

if [ -n "${1:-}" ]; then
  app_root="$(CDPATH= cd -- "$1" && pwd)"
elif [ -f "${pipeline_parent}/pubspec.yaml" ]; then
  app_root="$pipeline_parent"
else
  echo "usage: $0 <app_dir>" >&2
  echo "In the playground, run this from the repo root (no arguments)." >&2
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
  echo "Run ./coverage_pipeline/install-git-hooks.sh from the playground root."
  exit 0
fi

if [ "$pipeline_parent" != "$app_root" ]; then
  echo "install-git-hooks: copy coverage_pipeline/ next to pubspec.yaml in this repo, then run this script from there." >&2
  exit 1
fi

install_app_hooks "$app_root"
