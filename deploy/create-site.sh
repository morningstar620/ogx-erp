#!/usr/bin/env bash
# Create the ERPNext site and install apps. Run after the stack is healthy.
set -euo pipefail

SITE="${SITE:-erp.ogxstudio.in}"
DB_PASSWORD="${DB_PASSWORD:?Set DB_PASSWORD}"
ADMIN_PASSWORD="${ADMIN_PASSWORD:?Set ADMIN_PASSWORD}"
COMPOSE_FILE="${COMPOSE_FILE:-compose.ogx.yaml}"
PROJECT="${PROJECT:-ogx}"

docker compose -p "$PROJECT" -f "$COMPOSE_FILE" exec backend \
  bench new-site "$SITE" \
  --mariadb-root-password "$DB_PASSWORD" \
  --admin-password "$ADMIN_PASSWORD" \
  --install-app erpnext \
  --install-app ogx_studio

docker compose -p "$PROJECT" -f "$COMPOSE_FILE" exec backend \
  bench --site "$SITE" set-config -g dns_multitenant 1

echo "Site $SITE created. Open https://$SITE (Administrator / your ADMIN_PASSWORD)"
