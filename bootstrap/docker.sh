#!/usr/bin/env bash
set -Eeuo pipefail
source "${DOTFILES_ROOT:?}/bootstrap/lib/common.sh"

require_ubuntu
show_tool docker 'containers and local Compose development' 'Docker official APT repository' 'current stable' 're-run this group'
show_tool containerd 'container runtime used by Docker Engine' 'Docker containerd.io package' 'current stable' 're-run this group'
printf '\nPackages: docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin\n'
printf 'Daemon template: config/docker/daemon.json (merged with existing keys)\n'

if plan_only; then
  exit 0
fi

confirm_sudo 'Allow sudo APT and Docker daemon configuration for this group?'

architecture="$(dpkg --print-architecture)"
codename="${VERSION_CODENAME:?}"
keyring='/etc/apt/keyrings/docker.asc'
source_list='/etc/apt/sources.list.d/docker.list'
temp_dir="$(mktemp -d)"
trap 'rm -rf -- "$temp_dir"' EXIT

sudo apt-get update
sudo apt-get install -y -- ca-certificates curl jq
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o "$temp_dir/docker.asc"
sudo install -m 0755 -d /etc/apt/keyrings
sudo install -m 0644 "$temp_dir/docker.asc" "$keyring"
printf 'deb [arch=%s signed-by=%s] https://download.docker.com/linux/ubuntu %s stable\n' \
  "$architecture" "$keyring" "$codename" | sudo tee "$source_list" >/dev/null

conflicts=(docker.io docker-compose docker-compose-v2 docker-doc docker-buildx podman-docker containerd runc)
installed_conflicts=()
for package_name in "${conflicts[@]}"; do
  dpkg-query -W -f='${db:Status-Abbrev}' "$package_name" 2>/dev/null | grep -q '^ii ' && installed_conflicts+=("$package_name")
done
if ((${#installed_conflicts[@]})); then
  sudo apt-get remove -y -- "${installed_conflicts[@]}"
fi

sudo apt-get update
sudo apt-get install -y -- docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

current_config="$temp_dir/current.json"
merged_config="$temp_dir/daemon.json"
if sudo test -f /etc/docker/daemon.json; then
  sudo cp /etc/docker/daemon.json "$current_config"
  sudo chown "$(id -u):$(id -g)" "$current_config"
else
  printf '{}\n' >"$current_config"
fi
jq -s '.[0] * .[1]' "$current_config" "$DOTFILES_ROOT/config/docker/daemon.json" >"$merged_config"
sudo install -m 0755 -d /etc/docker
sudo cp -a /etc/docker/daemon.json "/etc/docker/daemon.json.backup.$(date +%Y%m%d%H%M%S)" 2>/dev/null || true
sudo install -m 0644 "$merged_config" /etc/docker/daemon.json
sudo dockerd --validate --config-file=/etc/docker/daemon.json

if ! getent group docker >/dev/null; then
  sudo groupadd docker
fi
if ! id -nG "$USER" | tr ' ' '\n' | grep -Fxq docker; then
  sudo usermod -aG docker "$USER"
fi

running_count="$(sudo docker ps -q 2>/dev/null | wc -l)"
if ((running_count > 0)); then
  warn "$running_count containers are running; daemon restart was not performed. Restart it during a safe window."
else
  confirm_sudo 'No containers are running. Restart and enable Docker/containerd now?'
  sudo systemctl enable --now containerd.service docker.service
  sudo systemctl restart docker.service
fi

log 'Docker installation and configuration completed. Open a new login session if group membership changed.'
