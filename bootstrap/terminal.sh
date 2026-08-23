#!/usr/bin/env bash
set -Eeuo pipefail
source "${DOTFILES_ROOT:?}/bootstrap/lib/common.sh"
require_ubuntu
show_tool zsh 'interactive shell' 'Ubuntu' 'distribution supported' 'apt upgrade'
show_tool fzf 'interactive fuzzy finder' 'Ubuntu or pinned upstream binary' 'capability detected at runtime' 'same install source'
show_tool zoxide 'directory navigation' 'pinned upstream package/binary' 'current stable' 're-run this group'
show_tool starship 'cross-shell prompt' 'pinned official release' 'current stable' 're-run this group'
show_tool zellij 'primary terminal multiplexer' 'pinned official release' 'current stable' 're-run this group'
show_tool lazygit 'Git terminal UI' 'pinned official release' 'current stable' 're-run this group'
show_tool eza 'modern directory listing' 'official eza repository or release' 'current stable' 'same install source'
plan_only && exit 0
warn 'Applying this group is intentionally limited to Ubuntu packages. Upstream binary upgrades require a separately reviewed version/checksum change.'
missing=()
for spec in 'zsh:zsh' 'fzf:fzf'; do
  command_name=${spec%%:*}; package_name=${spec#*:}; have "$command_name" || missing+=("$package_name")
done
((${#missing[@]} == 0)) && { log 'Ubuntu terminal packages are already installed.'; exit 0; }
apt_install "${missing[@]}"
