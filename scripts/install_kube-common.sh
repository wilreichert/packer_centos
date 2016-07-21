#!/bin/bash
set -e
set -x

KUBE_REL_TAG="v1.2.2"
KUBE_REL_URL="https://storage.googleapis.com/kubernetes-release/release/${KUBE_REL_TAG}/bin/linux/amd64"

KUBE_USER="kube"
KUBE_CERT_GROUP="kube-certs"
KUBE_CONFIG_DIR="/etc/kubernetes"
KUBE_SSL_DIR="/etc/kubernetes/ssl"

# Account
sudo groupadd -f kube-certs
sudo useradd -r -c "kubernetes service" -G kube-certs -M -d /dev/null -s /usr/sbin/nologin kube

sudo usermod -a -G kube centos

# Directories
sudo mkdir -p ${KUBE_CONFIG_DIR}
sudo chmod 755 ${KUBE_CONFIG_DIR}
sudo chown -R ${KUBE_USER}:${KUBE_USER} ${KUBE_CONFIG_DIR}

sudo mkdir -p ${KUBE_CONFIG_DIR}/manifests
sudo chmod 775 ${KUBE_CONFIG_DIR}/manifests
sudo chown -R ${KUBE_USER}:${KUBE_USER} ${KUBE_CONFIG_DIR}/manifests

sudo mkdir -p ${KUBE_SSL_DIR}
sudo chmod 750 ${KUBE_SSL_DIR}
sudo chown -R ${KUBE_USER}:${KUBE_CERT_GROUP} ${KUBE_SSL_DIR}

# Download release
sudo wget --progress=bar:force -N -P /usr/bin ${KUBE_REL_URL}/kubelet
sudo chmod +x /usr/bin/kubelet

sudo wget --progress=bar:force -N -P /usr/bin ${KUBE_REL_URL}/kube-proxy
sudo chmod +x /usr/bin/kube-proxy

sudo wget --progress=bar:force -N -P /usr/bin ${KUBE_REL_URL}/kubectl
sudo chmod +x /usr/bin/kubectl

# Testing
kubelet --version
kubectl version 2>/dev/null | grep Client # ignore server not found error
