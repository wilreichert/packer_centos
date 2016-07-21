#!/bin/bash
set -e
set -x

SETUP_VERSION=1.0.1
SETUP_URL=https://github.com/kelseyhightower/setup-network-environment/releases/download/${SETUP_VERSION}/setup-network-environment

# Systemd service config
sudo tee /etc/systemd/system/setup-network-environment.service <<-'EOF'
[Unit]
Description=Setup Network Environment
Documentation=https://github.com/kelseyhightower/setup-network-environment
Requires=network-online.target
After=network-online.target

[Service]
ExecStart=/usr/bin/setup-network-environment
RemainAfterExit=yes
Type=oneshot
EOF

# Download
sudo wget --progress=bar:force -N -P /usr/bin ${SETUP_URL}
sudo chmod +x /usr/bin/setup-network-environment

# Testing
setup-network-environment -o /tmp/test.env && cat /tmp/test.env
rm -f /tmp/test.env
