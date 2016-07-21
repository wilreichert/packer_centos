#!/bin/bash
set -e
set -x

sudo rm -rfv /tmp/*

sudo rm -fv /etc/ssh/ssh_*_key  # packer ssh keys
sudo rm -rfv /var/lib/cloud     # cloud init files

sudo find /var/log -type f -exec rm -fv {} \;

sudo yum -y clean all # remove cached packages and meta data

# Sync filesystem
# https://github.com/mitchellh/packer/issues/2044
sudo sync
