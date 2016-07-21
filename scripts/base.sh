sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
yum -y update
