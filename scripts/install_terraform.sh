#!/bin/bash
set -e
set -x

GOVER="1.6.2"
TERRAFORMVER="0.6.16"
PACKERVER="0.10.1"

# Install language dependencies
sudo yum install -y \
  git \
  gcc \
  python-devel

OS="linux"
ARCH="amd64"
wget https://storage.googleapis.com/golang/go$GOVER.$OS-$ARCH.tar.gz
sudo tar -C /usr/local -xzf go$GOVER.$OS-$ARCH.tar.gz
rm go$GOVER.$OS-$ARCH.tar.gz

# Add go bin to path
sudo tee /etc/profile <<-'EOF'

# golang paths
export PATH=$PATH:/usr/local/go/bin
EOF

# Install Python PIP
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo python get-pip.py
rm get-pip.py

# Install OpenStack python clients
sudo pip install \
  python-cinderclient \
  python-glanceclient \
  python-ironicclient \
  python-keystoneclient \
  python-neutronclient \
  python-novaclient \
  python-openstackclient

# Download and install Terraform
wget "https://releases.hashicorp.com/terraform/${TERRAFORMVER}/terraform_${TERRAFORMVER}_linux_amd64.zip"
sudo unzip -d /usr/local/bin "terraform_${TERRAFORMVER}_linux_amd64.zip"
rm "terraform_${TERRAFORMVER}_linux_amd64.zip"

# Verify Terraform install
terraform version

# Download and install Packer
wget "https://releases.hashicorp.com/packer/${PACKERVER}/packer_${PACKERVER}_linux_amd64.zip"
sudo unzip -d /usr/local/bin "packer_${PACKERVER}_linux_amd64.zip"
rm "packer_${PACKERVER}_linux_amd64.zip"

# Verify Packer install
packer version

# Download and install cfssl
export GO15VENDOREXPERIMENT=1 # CFSSL makes use of vendored packages
export GOPATH=~/go
export PATH=$PATH:/usr/local/go/bin
go get -u github.com/cloudflare/cfssl/cmd/...
sudo cp ~/go/bin/cfssl* /usr/local/bin

# Verify cfssl install
cfssl version

# Install jq
sudo wget "https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64" -O "/usr/local/bin/jq"
sudo chmod +x /usr/local/bin/jq

