#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
docker compose up -d
printf '\nWaiting for MySQL to be ready...\n'
for i in $(seq 1 60); do
  if docker exec index-research-mysql mysqladmin ping -h 127.0.0.1 -uroot -pprojectroot --silent >/dev/null 2>&1; then
    echo 'MySQL is ready.'
    exit 0
  fi
  sleep 2
done
echo 'MySQL did not become ready. Check: docker compose logs mysql' >&2
exit 1
