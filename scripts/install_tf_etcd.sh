#!/bin/bash
set -e
set -x

ETCD_DATA_DIR="/var/lib/etcd"

sudo mkdir -p /etc/etcd
sudo chmod 755 /etc/etcd
sudo chown -R etcd:etcd /etc/etcd

sudo mkdir -p ${ETCD_DATA_DIR}

for d in data log data-events log-events; do
  sudo mkdir -p ${ETCD_DATA_DIR}/${d}
done

sudo chmod -Rfv 750 ${ETCD_DATA_DIR}
sudo chown -Rfv etcd:etcd ${ETCD_DATA_DIR}


sudo tee /etc/systemd/system/etcd.service <<-EOF
[Unit]
Description=etcd server - terraform
Documentation=http://github.com/coreos/etcd
Requires=setup-network-environment.service
After=setup-network-environment.service

[Service]
User=etcd
Type=notify
ExecStart=/usr/bin/etcd --name=%H \
    --initial-cluster-state=new \
    --initial-cluster-token=etcd_tf \
    --data-dir=/var/lib/etcd/data \
    --wal-dir=/var/lib/etcd/log

Restart=always
RestartSec=10s
LimitNOFILE=40000

[Install]
WantedBy=multi-user.target

EOF

sudo systemctl daemon-reload
sudo systemctl enable etcd