#!/usr/bin/env bash
set -Eeuo pipefail
source "${DOTFILES_ROOT:?}/bootstrap/lib/common.sh"
require_ubuntu

readonly RAINFROG_VERSION=0.4.3
show_tool rainfrog 'database TUI for PostgreSQL, MySQL and SQLite' \
  'crates.io, Cargo --locked without optional DuckDB/Oracle' "$RAINFROG_VERSION" \
  './install.sh --apply database'
show_tool psql 'PostgreSQL command-line fallback' 'PostgreSQL/Ubuntu package' \
  'distribution supported' 'apt upgrade'

plan_only && exit 0
have cargo || die 'Cargo is required; install Rust with the languages group first.'

installed_version="$(rainfrog --version 2>/dev/null | awk 'NR == 1 { split($2, version, "-"); print version[1] }' || true)"
if [[ "$installed_version" == "$RAINFROG_VERSION" ]]; then
  log "Rainfrog $RAINFROG_VERSION is already installed."
  exit 0
fi

cargo install rainfrog --version "$RAINFROG_VERSION" --locked --no-default-features \
  --root "$HOME/.local"
