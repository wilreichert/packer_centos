#!/bin/bash
set -e
set -x

RPMDIR="/tmp/"

KMODVER="0.7.0-20160204"
YVIPVER="0.1-1"

sudo yum install -y \
  iptables-utils \
  iptables-services

sudo rpm -ivh \
  $RPMDIR/iptables-daddr-$KMODVER.el7.centos.x86_64.rpm \
  $RPMDIR/kmod-iptables-daddr-$KMODVER.el7.centos.x86_64.rpm \
  $RPMDIR/yvip-$YVIPVER.x86_64.rpm
