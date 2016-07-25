#!/bin/bash
set -e
set -x

DOCKER_VERSION="1.9.1-1"

# Install LVM2 for devicemapper
sudo yum -y -q install lvm2

sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

sudo yum -y -q install docker-engine-${DOCKER_VERSION}.el7.centos

# Lock the version at 1.9.1
# Prevents accidental upgrade to incompatible version
sudo yum versionlock docker-engine
sudo yum versionlock docker-engine-selinux
sudo usermod -aG docker centos

# Testing
docker --version
