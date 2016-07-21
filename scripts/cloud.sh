yum install -y acpid cloud-init cloud-utils-growpart
systemctl enable cloud-init
systemctl enable cloud-config
echo "user: centos" >> /etc/cloud/cloud.cfg
echo "NOZEROCONF=yes" >> /etc/sysconfig/network
sed -i 's/\(GRUB_CMDLINE_LINUX=\).*/\1"crashkernel=auto rhgb quiet console=tty0 console=ttyS0,115200n8"/' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
systemctl enable getty@ttyS0
