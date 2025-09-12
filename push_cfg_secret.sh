#!/bin/bash

NODES=("l2" "l3")

for node in "${NODES[@]}"; do
  echo ">>> Configuring $node"

  # Push Linux commands
  if [ -f configs/$node/linux_secret.cfg ]; then
    echo ">>> Configuring linux for node: $node"
    docker exec -i $node bash < configs/$node/linux_secret.cfg
  fi

  # Push FRR (vtysh) commands
  if [ -f configs/$node/frr.cfg ]; then
    echo ">>> Configuring frr for node: $node"
    docker exec -i $node vtysh < configs/$node/frr.cfg
  fi
done