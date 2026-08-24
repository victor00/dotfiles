#!/usr/bin/env bash
set -Eeuo pipefail
source "${DOTFILES_ROOT:?}/bootstrap/lib/common.sh"
require_ubuntu

readonly OBSIDIAN_VERSION=1.13.7
readonly OBSIDIAN_SHA256=17dc33b49cb3e785ecc27edd2ea0c79e40207798b554fd2886e36ebee7af9ae0
readonly OBSIDIAN_DEB="obsidian_${OBSIDIAN_VERSION}_amd64.deb"
readonly OBSIDIAN_URL="https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBSIDIAN_VERSION}/${OBSIDIAN_DEB}"
readonly PLUGIN_LOCK="$DOTFILES_ROOT/config/obsidian/plugins.lock"

show_tool obsidian 'local Markdown knowledge base' \
  'official obsidianmd/obsidian-releases Debian package with SHA-256 verification' \
  "$OBSIDIAN_VERSION" './install.sh --apply obsidian'
printf '\nCurated plugins (pinned and checksum-verified):\n'
awk -F '\t' 'NR > 1 { printf "  %-32s %s\n", $1, $3 }' "$PLUGIN_LOCK"
printf '\nVault selection: OBSIDIAN_VAULT, then the open vault in Obsidian registry.\n'

plan_only && exit 0
[[ "$(uname -m)" == x86_64 ]] || die 'The pinned Obsidian package supports x86_64 only.'
have curl || die 'curl is required; install the core group first.'
have jq || die 'jq is required; install the core or api-tools group first.'

temp_dir="$(mktemp -d)"
trap 'rm -rf -- "$temp_dir"' EXIT

installed_version="$(dpkg-query -W -f='${Version}' obsidian 2>/dev/null || true)"
if [[ "$installed_version" == "$OBSIDIAN_VERSION" ]]; then
  log "Obsidian $OBSIDIAN_VERSION is already installed."
else
  package="$temp_dir/$OBSIDIAN_DEB"
  curl -fL "$OBSIDIAN_URL" -o "$package"
  printf '%s  %s\n' "$OBSIDIAN_SHA256" "$package" | sha256sum --check --status || \
    die 'Obsidian package checksum verification failed.'
  confirm_sudo "Allow sudo installation of Obsidian $OBSIDIAN_VERSION?"
  sudo apt-get install -y -- "$package"
fi

vault="${OBSIDIAN_VAULT:-}"
if [[ -z "$vault" ]]; then
  registry="${XDG_CONFIG_HOME:-$HOME/.config}/obsidian/obsidian.json"
  if [[ -r "$registry" ]]; then
    vault="$(jq -r '([.vaults[] | select(.open == true)] + [.vaults[]])[0].path // empty' "$registry")"
  fi
fi
if [[ -z "$vault" ]]; then
  warn 'No vault found; set OBSIDIAN_VAULT=/absolute/path and re-run to install plugins.'
  exit 0
fi
[[ "$vault" == /* ]] || die 'OBSIDIAN_VAULT must be an absolute path.'
[[ -d "$vault/.obsidian" ]] || die "Not an Obsidian vault: $vault"

plugins_dir="$vault/.obsidian/plugins"
enabled_file="$vault/.obsidian/community-plugins.json"
mkdir -p "$plugins_dir"
[[ -f "$enabled_file" ]] || printf '%s\n' '[]' > "$enabled_file"

while IFS=$'\t' read -r plugin_id repo version manifest_sha main_sha styles_sha; do
  [[ "$plugin_id" == plugin_id ]] && continue
  release="https://github.com/$repo/releases/download/$version"
  staged="$temp_dir/$plugin_id"
  target="$plugins_dir/$plugin_id"
  mkdir -p "$staged" "$target"

  curl -fL "$release/manifest.json" -o "$staged/manifest.json"
  curl -fL "$release/main.js" -o "$staged/main.js"
  printf '%s  %s\n' "$manifest_sha" "$staged/manifest.json" | sha256sum --check --status || \
    die "$plugin_id manifest checksum verification failed."
  printf '%s  %s\n' "$main_sha" "$staged/main.js" | sha256sum --check --status || \
    die "$plugin_id main.js checksum verification failed."
  [[ "$(jq -r .id "$staged/manifest.json")" == "$plugin_id" ]] || die "$plugin_id manifest ID mismatch."
  [[ "$(jq -r .version "$staged/manifest.json")" == "$version" ]] || die "$plugin_id manifest version mismatch."

  install -m 0644 "$staged/manifest.json" "$target/manifest.json"
  install -m 0644 "$staged/main.js" "$target/main.js"
  if [[ "$styles_sha" != - ]]; then
    curl -fL "$release/styles.css" -o "$staged/styles.css"
    printf '%s  %s\n' "$styles_sha" "$staged/styles.css" | sha256sum --check --status || \
      die "$plugin_id styles.css checksum verification failed."
    install -m 0644 "$staged/styles.css" "$target/styles.css"
  fi

  jq --arg id "$plugin_id" '. + [$id] | unique' "$enabled_file" > "$temp_dir/community-plugins.json"
  install -m 0644 "$temp_dir/community-plugins.json" "$enabled_file"
  log "Installed $plugin_id $version."
done < "$PLUGIN_LOCK"

log "Obsidian plugins installed in $vault"
