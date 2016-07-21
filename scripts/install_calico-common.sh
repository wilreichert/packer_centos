#!/bin/bash
set -e
set -x

CALICO_REL_TAG="0.18.0"
CALICO_REL_URL="https://github.com/projectcalico/calico-containers/releases/download/v${CALICO_REL_TAG}"

CNI_REL_TAG="1.2.1"
CNI_REL_URL="https://github.com/projectcalico/calico-cni/releases/download/v${CNI_REL_TAG}"

# Download release
sudo wget --progress=bar:force -N -P /usr/bin ${CALICO_REL_URL}/calicoctl
sudo chmod +x /usr/bin/calicoctl

sudo wget --progress=bar:force -N -P /opt/cni/bin/ ${CNI_REL_URL}/calico
sudo chmod +x /opt/cni/bin/calico

sudo wget --progress=bar:force -N -P /opt/cni/bin/ ${CNI_REL_URL}/calico-ipam
sudo chmod +x /opt/cni/bin/calico-ipam

# Testing
calicoctl version
/opt/cni/bin/calico --version
/opt/cni/bin/calico-ipam --version
