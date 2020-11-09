#!/bin/bash

cd /usr/src/ 
yum update -y 
yum install wget mc ncurses-devel make gcc bc bison flex elfutils-libelf-devel openssl-devel grub2 centos-release-scl devtoolset-7 -y
echo "Soft Install"
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.4.75.tar.xz 
tar -xvf linux-5.4.75.tar.xz 
cd linux-5.4.75/ 
echo "kernel download"
make olddefconfig 
echo "create .config"
scl enable devtoolset-7 bash 
echo "Start MAKE!"
make 
echo "make kernel ok"
make modules 
make modules_install 
make install 
echo "kernel installed"
 
# Update GRUB
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-set-default 0
echo "Grub update done."
# Reboot VM
shutdown -r now
