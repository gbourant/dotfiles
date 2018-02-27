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

#gdisk
#EF00

if [ $1 -eq 1 ]
then

mkfs.vfat /dev/sdb1
mkfs.ext4 /dev/sdb2

#mount disks
mount /dev/sdb2 /mnt
mkdir /mnt/boot
mount /dev/sdb1 /mnt/boot

#enable internet access
#dhcpcd


echo '## Greece
Server = http://ftp.cc.uoc.gr/mirrors/linux/archlinux/$repo/os/$arch
Server = http://foss.aueb.gr/mirrors/linux/archlinux/$repo/os/$arch
Server = http://mirrors.myaegean.gr/linux/archlinux/$repo/os/$arch
Server = http://ftp.ntua.gr/pub/linux/archlinux/$repo/os/$arch
Server = http://ftp.otenet.gr/linux/archlinux/$repo/os/$arch

## Italy
Server = http://mi.mirror.garr.it/mirrors/archlinux/$repo/os/$arch
Server = http://mirrors.prometeus.net/archlinux/$repo/os/$arch
Server = http://archlinux.students.cs.unibo.it/$repo/os/$arch

## Czech Republic
Server = http://mirror.dkm.cz/archlinux/$repo/os/$arch
Server = http://ftp.fi.muni.cz/pub/linux/arch/$repo/os/$arch
Server = http://ftp.linux.cz/pub/linux/arch/$repo/os/$arch


## France
Server = http://archlinux.de-labrusse.fr/$repo/os/$arch
Server = http://mirror.archlinux.ikoula.com/archlinux/$repo/os/$arch
Server = http://archlinux.vi-di.fr/$repo/os/$arch


## Germany
Server = http://mirror.23media.de/archlinux/$repo/os/$arch
Server = http://artfiles.org/archlinux.org/$repo/os/$arch
Server = http://arch.eckner.net/archlinux/$repo/os/$arch

## Netherlands
Server = http://mirror.i3d.net/pub/archlinux/$repo/os/$arch
Server = http://mirror.koddos.net/archlinux/$repo/os/$arch
Server = http://mirror.ams1.nl.leaseweb.net/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist

#update system
pacman -Syy --noconfirm
#pacman -S --noconfirm reflector
#reflector --latest 10 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist


#install arch
pacstrap /mnt base base-devel
#pacstrap -i /mnt base base-devel

#mount disk corrent
genfstab -U -p /mnt > /mnt/etc/fstab


echo "run state 2 of execute script"
#echo "---------------------curl -O 192.168.10.9:4242/installer.sh"
echo "pacman -S git"
echo "git clone https://github.com/gbourant/dotfiles.git ~/.dotfiles"

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

bootctl install
echo "default arch" > /boot/loader/loader.conf
echo "timeout 4" >> /boot/loader/loader.conf

echo "title Archlinux x64" > /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "options root=/dev/sdb2 rw" >> /boot/loader/entries/arch.conf

echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf

pacman -Syy --noconfirm
#pacman -S --noconfirm reflector
#reflector --latest 10 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist



echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "el_GR.UTF-8 UTF-8" >> /etc/locale.gen

locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
#grub os-prober
pacman -S --noconfirm systemd-swap linux-lts linux-lts-headers git
#pacman -S --noconfirm virtualbox-guest-utils

#intel stuff
echo "installing intel staff"
pacman -S --noconfirm intel-ucode
mkinitcpio -p linux

echo "zswap_enabled=0" >> /etc/systemd/swap.conf.d/systemd-swap.conf
echo "swapfc_enabled=1" >> /etc/systemd/swap.conf.d/systemd-swap.conf

systemctl enable systemd-swap
#systemctl enable sshd.service
#systemctl enable dhcpcd@enp0s3.service

systemctl enable dhcpcd@enp2s0.service

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
echo "gbourant:pass" | chpasswd
#echo pass | passwd gbourant --stdin
#passwd gbourant
##############

#runuser -s /bin/bash -l gbourant -c 'curl -O 192.168.10.9:4242/postInstall.sh'
runuser -s /bin/bash -l gbourant -c 'git clone https://github.com/gbourant/dotfiles.git ~/.dotfiles'

#grub-install /dev/sda
#cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en
#grub-mkconfig -o /boot/grub/grub.cfg

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
