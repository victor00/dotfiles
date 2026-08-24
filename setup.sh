#!/usr/bin/env bash
set -Eeuo pipefail

DOTFILES_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
readonly DOTFILES_ROOT
cd "$DOTFILES_ROOT"

usage() {
  cat <<'EOF'
Usage: ./setup.sh [--plan|--apply]

Interactive dotfiles installer. Each step is explained and can be included or
skipped. Plan mode is the default and never installs packages or creates links.
Use --apply to allow selected steps to change the machine after their own safety
confirmations.
EOF
}

die() { printf 'error: %s\n' "$*" >&2; exit 1; }

mode=plan
case "${1:-}" in
  '') ;;
  --plan) ;;
  --apply) mode=apply ;;
  -h|--help) usage; exit 0 ;;
  *) die "unknown option: $1" ;;
esac
[[ $# -le 1 ]] || die 'only one option is accepted'
[[ -t 0 ]] || die 'interactive setup requires a terminal'

selected=()

choose() {
  local key="$1" title="$2" description="$3" answer
  printf '\n\033[1;34m%s\033[0m\n%s\n' "$title" "$description"
  while true; do
    read -r -p 'Include this step? [y/N/q] ' answer || exit 130
    case "$answer" in
      y|Y|yes|YES) selected+=("$key"); printf 'selected\n'; return ;;
      ''|n|N|no|NO|s|S|skip|SKIP) printf 'skipped\n'; return ;;
      q|Q|quit|QUIT) printf 'Setup cancelled.\n'; exit 0 ;;
      *) printf 'Choose y to include, Enter/n to skip, or q to quit.\n' ;;
    esac
  done
}

printf '\nDotfiles interactive setup\n'
printf 'Mode: %s\n' "$mode"
printf 'Every step can be skipped. Existing files are never overwritten.\n'

choose core 'Core utilities' 'Installs Git, curl, jq, ripgrep, fd, eza and other essential command-line tools.'
choose terminal 'Terminal environment' 'Installs Zsh, Starship, Zellij, fzf, zoxide and LazyGit.'
choose languages 'Language manager' 'Installs mise; project files continue to control runtime versions.'
choose development 'Development tooling' 'Installs shared lint and formatting tools such as ShellCheck, shfmt and actionlint.'
choose docker 'Docker development' 'Installs or updates Docker Engine, CLI, containerd, Buildx and Compose from Docker official packages.'
choose database 'Database terminal' 'Installs the Rainfrog database TUI without storing credentials in the repository.'
choose api-tools 'API command-line tools' 'Installs HTTPie, jq and yq for HTTP, JSON and YAML workflows.'
choose grpc-tools 'gRPC tools' 'Installs grpcurl and describes the optional WebSocket client.'
choose bruno 'Bruno Desktop' 'Shows or applies the optional Bruno API client installation workflow.'
choose desktop 'Desktop terminal and font' 'Installs Ghostty and JetBrainsMono Nerd Font using the supported desktop bootstrap.'
choose obsidian 'Obsidian knowledge base' 'Installs the pinned Obsidian desktop package and checksum-verified community plugins in the active vault.'
choose links 'Dotfiles links' 'Links versioned configuration into the home directory; conflicts are reported and never overwritten.'

if ((${#selected[@]} == 0)); then
  printf '\nNothing selected; no changes made.\n'
  exit 0
fi

printf '\nSelected steps:\n'
printf '  - %s\n' "${selected[@]}"
if [[ "$mode" == apply ]]; then
  read -r -p 'Apply these selected steps now? [y/N] ' answer || exit 130
  [[ "$answer" =~ ^[Yy]$ ]] || { printf 'Setup cancelled; no selected steps were applied.\n'; exit 0; }
else
  printf 'Plan mode will only show what each selected step would do.\n'
fi

for step in "${selected[@]}"; do
  printf '\n\033[1;34m==> %s\033[0m\n' "$step"
  if [[ "$step" == links ]]; then
    if [[ "$mode" == apply ]]; then
      scripts/link-config --apply
    else
      scripts/link-config
    fi
  elif [[ "$mode" == apply ]]; then
    ./install.sh --apply "$step"
  else
    ./install.sh "$step"
  fi
done

printf '\nSetup finished in %s mode.\n' "$mode"
if [[ "$mode" == plan ]]; then
  printf 'Re-run with ./setup.sh --apply when the plan is approved.\n'
fi
