#!/bin/bash
set -e

echo "Starting container setup..."

# Modify /etc/frr/daemons for common configuration
cat <<EOL >/etc/frr/daemons
zebra=yes
bgpd=yes
ospfd=yes
vtysh_enable=yes
EOL

# Start FRR
echo "Starting FRR..."
/usr/lib/frr/frrinit.sh start

# Keep the container running
tail -f /dev/null