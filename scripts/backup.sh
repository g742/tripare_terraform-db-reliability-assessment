#!/bin/bash

set -e

BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/hotel_db_${TIMESTAMP}.sql"

mkdir -p "$BACKUP_DIR"

docker exec hotel-postgres \
  pg_dump -U hotel_user -d hotel_db \
  > "$BACKUP_FILE"

echo "Backup created: $BACKUP_FILE"
