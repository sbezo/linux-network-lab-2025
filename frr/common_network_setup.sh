#!/bin/bash

# This script is called by the Dockerfile to set up common network configurations
# and start the FRR service in a container.
# There should be common setups for all containers baked to image here.


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