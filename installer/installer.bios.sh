#!/bin/bash

#add /etc/host localhost etc etc

#curl -O 192.168.10.9:4242/installer.sh

#create 2 partition

#fdisk /dev/sda
#o -> wipes the drive
#n -> new partition
#primary
#ex. +10G
#a -> bootable flag on first disk only
#w -> exit

#format disks

if [ $1 -eq 1 ]
then

mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda2

#mount disks
mount /dev/sda1 /mnt
mkdir /mnt/home
mount /dev/sda2 /mnt/home

#enable internet access
#dhcpcd

#update system
pacman -Syy --noconfirm
pacman -S --noconfirm reflector
reflector --latest 10 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist


#install arch
pacstrap /mnt base base-devel
#pacstrap -i /mnt base base-devel

#mount disk corrent
genfstab -U -p /mnt >> /mnt/etc/fstab


echo "run state 2 of execute script"
echo "---------------------curl -O 192.168.10.9:4242/installer.sh"

#arch-chroot /mnt curl -O "192.168.10.9:4242/installer.sh";chmod +x installer.sh;./installer.sh 2
arch-chroot /mnt
#run the second script


fi


if [ $1 -eq 2 ]
then
#run script

#grub needed for bootloader
#os-prober helps grub-mkconfig to auto find bootable os in disks
#openssh ssh app
#neovim (nvim) vim alternative
#yaourt user repo
#systemd-swap file based swap
#linux-lts latest kernel
#linux-lts-headers needed for some apps
#wpa_supplicant  for wireless
#wireless_tools for wireless

echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf

pacman -Syy --noconfirm
pacman -S --noconfirm reflector
reflector --latest 10 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "el_GR.UTF-8 UTF-8" >> /etc/locale.gen

locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

pacman -S --noconfirm grub os-prober systemd-swap linux-lts linux-lts-headers
pacman -S --noconfirm virtualbox-guest-utils

#intel stuff
echo "installing intel staff"
pacman -S --noconfirm intel-ucode
mkinitcpio -p linux

echo "zswap_enabled=0" >> /etc/systemd/swap.conf.d/systemd-swap.conf
echo "swapfc_enabled=1" >> /etc/systemd/swap.conf.d/systemd-swap.conf

systemctl enable systemd-swap
systemctl enable sshd.service
systemctl enable dhcpcd@enp0s3.service

ln -sf /usr/share/zoneinfo/Europe/Athens /etc/localtime
hwclock --systohc --utc

echo "TheMachine" > /etc/hostname
echo "enter root password"
echo "root:pass" | chpasswd

#############

#useradd -m -G users -s /bin/bash gbourant
useradd -m -G users -s /bin/zsh gbourant
echo "gbourant ALL=(ALL) ALL" >> /etc/sudoers
echo "enter gbourant password"
echo "gbourant:pass" | sudo chpasswd
#echo pass | passwd gbourant --stdin
#passwd gbourant
##############

#runuser -s /bin/bash -l gbourant -c 'curl -O 192.168.10.9:4242/postInstall.sh'

grub-install /dev/sda
cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en
grub-mkconfig -o /boot/grub/grub.cfg

echo "after state 2 exit the new instance bash with 'exit' command"
echo "-----------------umount -R /mnt"
echo "-----------------reboot"
fi

if [ $1 -eq 3 ]
then

umount -R /mnt
reboot


fi
#ip link set en0s3 up