
#!/usr/bin/env bash
set -euo pipefail

echo "Installing MySQL..."

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server mysql-client

echo "Starting MySQL..."
sudo service mysql start

echo "Verifying MySQL..."
mysql --version
sudo mysql -e "SELECT VERSION();"

echo "MySQL setup completed."
