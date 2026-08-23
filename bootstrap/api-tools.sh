#!/usr/bin/env bash
set -Eeuo pipefail
source "${DOTFILES_ROOT:?}/bootstrap/lib/common.sh"
require_ubuntu
show_tool curl 'universal API diagnostics and scripts' 'Ubuntu' 'distribution supported' 'apt upgrade'
show_tool jq 'JSON filtering and formatting' 'Ubuntu' 'distribution supported' 'apt upgrade'
show_tool yq 'YAML processor' 'pinned mikefarah/yq release' 'v4 stable' 're-run this group'
show_tool http 'readable terminal HTTP client' 'official HTTPie package/pipx' 'current stable' 'same install source'
plan_only && exit 0
missing=(); have curl || missing+=(curl); have jq || missing+=(jq)
((${#missing[@]} == 0)) && { log 'Base API tools are already installed. Optional HTTPie/yq upgrades remain unchanged.'; exit 0; }
apt_install "${missing[@]}"
