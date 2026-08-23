#!/usr/bin/env bash
set -Eeuo pipefail
source "${DOTFILES_ROOT:?}/bootstrap/lib/common.sh"
require_ubuntu
show_tool git 'version control' 'Ubuntu or Git official repository' '>= 2.19' 'same package source'
show_tool curl 'universal HTTP client' 'Ubuntu' 'distribution supported' 'apt upgrade'
show_tool jq 'JSON processor' 'Ubuntu' 'distribution supported' 'apt upgrade'
show_tool rg 'fast text search' 'Ubuntu/upstream binary' 'current stable' 'same install source'
show_tool fd 'fast file finder' 'Ubuntu/upstream binary' 'current stable' 'same install source'
show_tool bat 'syntax-aware file viewer' 'Ubuntu/upstream binary' 'current stable' 'same install source'
plan_only && exit 0
missing=()
for spec in 'git:git' 'curl:curl' 'jq:jq' 'rg:ripgrep' 'fdfind:fd-find' 'batcat:bat'; do
  command_name=${spec%%:*}; package_name=${spec#*:}
  have "$command_name" || missing+=("$package_name")
done
((${#missing[@]} == 0)) && { log 'Core tools are already installed.'; exit 0; }
apt_install "${missing[@]}"
