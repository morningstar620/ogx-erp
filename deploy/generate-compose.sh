#!/usr/bin/env bash
# Generate compose.ogx.yaml from frappe_docker overrides (HTTPS + MariaDB + Redis).
# Run from inside the frappe_docker directory with deploy/.env present.
set -euo pipefail

ENV_FILE="${1:-.env}"

docker compose --env-file "$ENV_FILE" \
  -f compose.yaml \
  -f overrides/compose.mariadb.yaml \
  -f overrides/compose.redis.yaml \
  -f overrides/compose.proxy.yaml \
  -f overrides/compose.https.yaml \
  config > compose.ogx.yaml

echo "Wrote compose.ogx.yaml — start with: docker compose -p ogx -f compose.ogx.yaml up -d"
