#!/usr/bin/env bash
set -Eeuo pipefail
source "${DOTFILES_ROOT:?}/bootstrap/lib/common.sh"
require_ubuntu

have_zsh_syntax_highlighting() {
  [[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ||
    -r "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ||
    -r "$HOME/.local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]
}

show_tool git 'version control' 'Ubuntu or Git official repository' '>= 2.19' 'same package source'
show_tool curl 'universal HTTP client' 'Ubuntu' 'distribution supported' 'apt upgrade'
show_tool jq 'JSON processor' 'Ubuntu' 'distribution supported' 'apt upgrade'
show_tool rg 'fast text search' 'Ubuntu/upstream binary' 'current stable' 'same install source'
show_tool fd 'fast file finder' 'Ubuntu/upstream binary' 'current stable' 'same install source'
show_tool bat 'syntax-aware file viewer' 'Ubuntu/upstream binary' 'current stable' 'same install source'
show_tool tldr 'practical command documentation' 'Ubuntu' 'distribution supported' 'apt upgrade'
show_tool ss 'local port inspection' 'Ubuntu iproute2' 'distribution supported' 'apt upgrade'
show_tool xdg-open 'explicit URL opening' 'Ubuntu xdg-utils' 'distribution supported' 'apt upgrade'
printf '\n%-14s %s\n  purpose: %s\n  origin:  %s\n  version: %s\n  update:  %s\n' \
  zsh-highlighting "$(have_zsh_syntax_highlighting && printf '[installed]' || printf '[missing]')" \
  'valid-command highlighting while typing' 'Ubuntu or existing Oh My Zsh plugin' \
  'distribution supported' 'apt upgrade or plugin manager'
plan_only && exit 0
missing=()
for spec in 'git:git' 'curl:curl' 'jq:jq' 'rg:ripgrep' 'fdfind:fd-find' 'batcat:bat' \
  'tldr:tldr' 'ss:iproute2' 'xdg-open:xdg-utils' 'man:man-db'; do
  command_name=${spec%%:*}; package_name=${spec#*:}
  have "$command_name" || missing+=("$package_name")
done
have_zsh_syntax_highlighting || missing+=(zsh-syntax-highlighting)
((${#missing[@]} == 0)) && { log 'Core tools are already installed.'; exit 0; }
apt_install "${missing[@]}"
