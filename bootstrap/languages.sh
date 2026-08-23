#!/usr/bin/env bash
set -Eeuo pipefail
source "${DOTFILES_ROOT:?}/bootstrap/lib/common.sh"
require_ubuntu
show_tool mise 'project runtime manager for Ruby, Node, Python, Go and Java' 'official mise release or APT repository' 'current stable, pinned by installer' 'mise self-update or package manager'
printf '\nExisting rbenv/NVM/manual runtimes are preserved during migration. No runtime is installed globally by this target.\n'
plan_only && exit 0
die 'mise installation needs a reviewed pinned version and checksum. Update bootstrap/languages.sh before applying.'
