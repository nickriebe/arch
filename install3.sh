#!/bin/bash
#
# Title:      ArchLinux (Reference Title File)
# Author(s):  NickRiebe
# URL:        https://nickriebe.com
# GNU:        General Public License v3.0
################################################################################

# Launch into Fdisk
fdisk /dev/mmcblk0
d
2
d
1
n
1
echo -ne '\n'
+512M
y
t
1
n
2
echo -ne '\n'
echo -ne '\n'
y
w

# Format the drive
##################
mkfs.fat -F32 /dev/mmcblk0p1
mkfs.ext4 /dev/mmcblk0p2

# Set up Wi-Fi
##############
#iwctl

# Mount second partition
mount /dev/mmcblk0p2 /mnt
pacstrap /mnt base linux linux-firmware nano

# create files and create fstab files
genfstab -U /mnt /mnt/etc/fstab

# jump into the environment
arch-chroot /mnt

# change password
passwd
999
999

# create locale gen
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen

# locale-gen command
local-gen

# export to local config file
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

# time
timedatectf set-timezone America/Chicago

# hostname
echo workbench > /etc/hostname

# hosts file
echo '127.0.0.1 \t localhost' > /etc/hosts
echo '::1 \t localhost' > /etc/hosts
echo '127.0.1.1 \t workbench' > /etc/hosts

# set up bootloader
mkdir /boot/efi
mount /dev/mmcblk0p1 /boot/efi
pacman -S grub efibootmgr -y
grub-install --target=x86_64-efi --bootloader-id=ARCH --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

# run into issue where can boot?
mkdir /boot/efi/EFI/boot
cp /boot/efi/EFI/ARCH/grubx64.efi /boot/efi/EFI/boot/bootx64.efi

# ready to set up environment
pacman -S -noconfirm xorg

# now choose your environment
