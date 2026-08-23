#!/usr/bin/env bash
set -Eeuo pipefail
source "${DOTFILES_ROOT:?}/bootstrap/lib/common.sh"
require_ubuntu
show_tool bru 'run existing project-owned Bruno collections' 'Bruno official package' 'optional current stable' 'same official package source'
printf '\nBruno Desktop is the preferred visual client. Bruno CLI remains separate and optional.\n'
plan_only && exit 0
die 'Bruno requires explicit approval of its official package source. No installation was performed.'
