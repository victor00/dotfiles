#!/usr/bin/env bash

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mwarning:\033[0m %s\n' "$*" >&2; }
die() { printf '\033[1;31merror:\033[0m %s\n' "$*" >&2; exit 1; }

have() { command -v "$1" >/dev/null 2>&1; }

require_ubuntu() {
  [[ -r /etc/os-release ]] || die 'Cannot identify the operating system.'
  # shellcheck disable=SC1091
  source /etc/os-release
  [[ "${ID:-}" == ubuntu ]] || die 'This installer currently supports Ubuntu only.'
  log "Detected Ubuntu ${VERSION_ID:-unknown} (${VERSION_CODENAME:-unknown})"
}

show_tool() {
  local name="$1" purpose="$2" origin="$3" version="$4" update="$5"
  printf '\n%-14s %s\n  purpose: %s\n  origin:  %s\n  version: %s\n  update:  %s\n' \
    "$name" "$(have "$name" && printf '[installed]' || printf '[missing]')" \
    "$purpose" "$origin" "$version" "$update"
}

plan_only() {
  if [[ "${DOTFILES_APPLY:-false}" != true ]]; then
    printf '\nPlan only. Re-run with --apply after reviewing the tools above.\n'
    return 0
  fi
  return 1
}

confirm_sudo() {
  local answer prompt="$1"
  [[ -t 0 ]] || die 'sudo installation requires an interactive terminal.'
  read -r -p "$prompt [y/N] " answer
  [[ "$answer" =~ ^[Yy]$ ]] || die 'Installation cancelled.'
}

apt_install() {
  (($# > 0)) || return 0
  confirm_sudo 'Allow sudo apt operations for this group?'
  sudo apt-get update
  sudo apt-get install -y -- "$@"
}
