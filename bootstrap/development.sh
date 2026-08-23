#!/usr/bin/env bash
set -Eeuo pipefail
source "${DOTFILES_ROOT:?}/bootstrap/lib/common.sh"
require_ubuntu
show_tool gh 'GitHub CLI' 'GitHub official APT repository' 'current stable' 'apt upgrade'
show_tool shellcheck 'shell static analysis' 'Ubuntu' 'distribution supported' 'apt upgrade'
show_tool shfmt 'shell formatter' 'pinned upstream binary' 'current stable' 're-run this group'
show_tool actionlint 'GitHub Actions linter' 'pinned upstream binary' 'current stable' 're-run this group'
show_tool hadolint 'Dockerfile linter' 'pinned upstream binary' 'current stable' 're-run this group'
show_tool tree-sitter 'parser compiler required by current LazyVim' 'tree-sitter-cli compiled with Cargo --locked' 'current crates.io release' 'cargo install tree-sitter-cli --locked'
plan_only && exit 0
missing=(); have shellcheck || missing+=(shellcheck)
((${#missing[@]} == 0)) && { log 'Available Ubuntu development packages are installed.'; exit 0; }
apt_install "${missing[@]}"
