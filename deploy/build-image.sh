#!/usr/bin/env bash
# Build the custom Ogx Studio ERPNext image inside a frappe_docker checkout.
# Usage: ./deploy/build-image.sh /path/to/frappe_docker
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FRAPPE_DOCKER="${1:-$HOME/frappe_docker}"

if [[ ! -d "$FRAPPE_DOCKER" ]]; then
  echo "frappe_docker not found at $FRAPPE_DOCKER"
  echo "Clone it first: git clone https://github.com/frappe/frappe_docker $FRAPPE_DOCKER"
  exit 1
fi

cp "$ROOT/apps.json" "$FRAPPE_DOCKER/apps.json"

cd "$FRAPPE_DOCKER"
docker build \
  --no-cache \
  --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe \
  --build-arg=FRAPPE_BRANCH=version-15 \
  --secret=id=apps_json,src=apps.json \
  --tag=ogx-erp:v15 \
  --file=images/layered/Containerfile \
  .
