
#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 || ! -f "$1" ]]; then
    echo "Usage: bash scripts/run-sql.sh sql/01_create_database.sql" >&2
    exit 2
fi

# Execute the SQL file using the local MySQL server.
sudo mysql --table < "$1"
