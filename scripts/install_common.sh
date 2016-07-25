#!/bin/bash
set -e
set -x

sudo yum -y -q update

# base cloud packages
sudo yum -y -q install cloud-utils \
                       gdisk \
                       ncurses-term \
                       python-pip \
                       curl \
                       wget \
                       git \
                       unzip \
                       python-yaml \
                       logrotate \
                       bridge-utils \
                       ipset \
                       nfs-common \
                       btrfs-tools \
                       socat \
                       yum-versionlock

# Disable sudo requiretty for remote SCM over SSH
sudo sed -i -e 's/^Defaults\s\+requiretty/# \0/' /etc/sudoers
