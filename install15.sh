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
