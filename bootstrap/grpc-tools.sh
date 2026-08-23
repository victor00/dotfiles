#!/usr/bin/env bash
set -Eeuo pipefail
source "${DOTFILES_ROOT:?}/bootstrap/lib/common.sh"
require_ubuntu
show_tool grpcurl 'inspect and call gRPC services' 'pinned fullstorydev/grpcurl release' 'current stable' 're-run this group'
show_tool websocat 'lightweight WebSocket client' 'pinned viacob/websocat release' 'optional current stable' 're-run this group'
plan_only && exit 0
die 'gRPC/WebSocket binaries require pinned versions and checksums before applying.'
