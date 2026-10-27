#!/usr/bin/env bash
set -euo pipefail
if [[ $# -ne 1 || ! -f "$1" ]]; then
  echo 'Usage: bash scripts/run-sql.sh sql/01_create_database.sql' >&2
  exit 2
fi
docker exec -i index-research-mysql mysql -uroot -pprojectroot --table < "$1"
