#!/bin/bash
set -e
set -x

ETCD_VERSION="2.2.1"
ETCD_URL="https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz"

# Account
sudo groupadd -f kube-certs
sudo useradd -r -c "etcd service" -G kube-certs -M -d /dev/null -s /usr/sbin/nologin etcd

# Download release
curl -L ${ETCD_URL} -o /tmp/etcd.tgz
mkdir -p /tmp/etcd
tar xzf /tmp/etcd.tgz -C /tmp/etcd --strip-components 1

# etcd binary
sudo cp /tmp/etcd/etcd /usr/bin/etcd
sudo chown root:root /usr/bin/etcd
sudo chmod 755 /usr/bin/etcd

# etcdctl binary
sudo cp /tmp/etcd/etcdctl /usr/bin/etcdctl
sudo chown root:root /usr/bin/etcdctl
sudo chmod 755 /usr/bin/etcdctl

# Cleanup
rm -rf /tmp/etcd /tmp/etcd.tgz

# Testing
etcd --version
etcdctl --version
