#!/usr/bin/env bash
set -Eeuo pipefail
source "${DOTFILES_ROOT:?}/bootstrap/lib/common.sh"
require_ubuntu
show_tool ghostty 'GPU terminal renderer' 'Snap Store classic package referenced by Ghostty documentation' 'current stable channel' 'sudo snap refresh ghostty'
printf '\nUbuntu 22.04 has no native APT package. This target uses Snap and does not run curl | sh. Fonts are not modified.\n'
plan_only && exit 0
if have ghostty; then
  log 'Ghostty is already installed.'
  exit 0
fi
have snap || die 'snap is required on Ubuntu 22.04.'
confirm_sudo 'Allow sudo snap installation for Ghostty?'
sudo snap install ghostty --classic
