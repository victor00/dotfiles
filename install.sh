#!/usr/bin/env bash
set -Eeuo pipefail

DOTFILES_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
readonly DOTFILES_ROOT
export DOTFILES_ROOT

usage() {
  cat <<'EOF'
Usage: ./install.sh [--apply] GROUP

Groups:
  core          Essential shell and file tools
  terminal      Zsh, fzf, zoxide, Starship, Zellij and LazyGit
  languages     mise runtime manager (runtimes remain project-controlled)
  development   Shared development and lint tools
  docker        Docker Engine, CLI, containerd, Buildx and Compose
  database      Rainfrog database TUI (PostgreSQL priority)
  api-tools     HTTPie, jq and yq
  bruno         Optional Bruno Desktop information/installer
  grpc-tools    grpcurl and optional WebSocket CLI
  desktop       Optional terminal and fonts
  obsidian      Obsidian desktop and pinned community plugins

The default is a plan only. Pass --apply to allow an installer to make changes.
No group runs sudo without an additional interactive confirmation.
EOF
}

apply=false
if [[ "${1:-}" == "--apply" ]]; then
  apply=true
  shift
fi

group="${1:-}"
case "$group" in
  -h|--help|"") usage; exit 0 ;;
  core|terminal|languages|development|docker|database|api-tools|bruno|grpc-tools|desktop|obsidian) ;;
  *) printf 'Unknown group: %s\n' "$group" >&2; usage >&2; exit 2 ;;
esac

export DOTFILES_APPLY="$apply"
exec "$DOTFILES_ROOT/bootstrap/${group}.sh"
