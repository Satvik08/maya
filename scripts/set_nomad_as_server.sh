#!/bin/bash

set -e

if [ $# -ne 4 ]; then
    echo $0: usage: set_nomad_as_server SELF_IPV4 SELF_HOSTNAME ALL_SERVERS_IPV4 S_NODES
    exit 1
fi

SELF_IPV4=$1
SELF_HOSTNAME=$2
ALL_SERVERS_IPV4=$3
S_NODES=$4

echo "Set nomad in server mode ..."

# Place nomad config template 
sudo cp /etc/maya.d/templates/nomad-server.hcl.tmpl /etc/nomad.d/server/nomad-server.hcl

# Place systemd service template for nomad
sudo cp /etc/maya.d/templates/nomad-server.service.tmpl /etc/systemd/system/nomad-server.service

# Replace the placeholders with actual values
sudo sed -e "s|__SELF_IPV4__|$SELF_IPV4|g" -i /etc/nomad.d/server/nomad-server.hcl
sudo sed -e "s|__S_NODES__|$S_NODES|g" -i /etc/nomad.d/server/nomad-server.hcl
sudo sed -e "s|__ALL_SERVERS_IPV4__|$ALL_SERVERS_IPV4|g" -i /etc/nomad.d/server/nomad-server.hcl