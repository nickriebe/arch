fdisk /dev/mmcblk0
d
2
d
n
1
2048
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
umount /dev/mmcblk0*
mkfs.fat -F32 /dev/mmcblk0p1
mkfs.ext4 /dev/mmcblk0p2
mount /dev/mmcblk0p2 /mnt
pacstrap /mnt base linux linux-firmware nano
genfstab -U /mnt /mnt/etc/fstab
arch-chroot /mnt
passwd
999
999
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
timedatectl set-timezone America/Chicago
echo workbench > /etc/hostname
echo -e "127.0.0.1 \tlocalhost" > /etc/hosts
echo -e "::1 \tlocalhost" >> /etc/hosts
echo -e "127.0.1.1 \tworkbench" >> /etc/hosts
mkdir /boot/efi
mount /dev/mmcblk0p1 /boot/efi
pacman -S grub --noconfirm efibootmgr
grub-install --target=x86_64-efi --bootloader-id=ARCH --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
mkdir /boot/efi/EFI/boot
cp /boot/efi/EFI/ARCH/grubx64.efi /boot/efi/EFI/boot/bootx64.efi
pacman -S --noconfirm xorg
pacman -S gnome
systemctl enable gdm
systemctl enable NetworkManager
pacman -S xfce4 xfce4-goodies
