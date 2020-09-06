mkfs.fat -F32 /dev/mmcblk0p1
mkfs.ext4 /dev/mmcblk0p2 |

# Mount second partition
mount /dev/mmcblk0p2 /mnt
pacstrap /mnt base linux linux-firmware nano |

# create files and create fstab files
genfstab -U /mnt /mnt/etc/fstab |

# jump into the environment
arch-chroot /mnt |

# change password
passwd
999
999 |

# create locale gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen |

# locale-gen command
locale-gen |

# export to local config file
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8 |

# time
timedatectl set-timezone America/Chicago |

# hostname
echo workbench > /etc/hostname |

# hosts file
echo -e "127.0.0.1 \tlocalhost" > /etc/hosts
echo -e "::1 \tlocalhost" >> /etc/hosts
echo -e "127.0.1.1 \tworkbench" >> /etc/hosts |

# set up bootloader
mkdir /boot/efi
mount /dev/mmcblk0p1 /boot/efi
pacman -S grub --noconfirm efibootmgr
grub-install --target=x86_64-efi --bootloader-id=ARCH --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg |

# run into issue where can boot?
mkdir /boot/efi/EFI/boot
cp /boot/efi/EFI/ARCH/grubx64.efi /boot/efi/EFI/boot/bootx64.efi |

# ready to set up environment
pacman -S --noconfirm xorg |

# now need to pick a desktop environment
# for gnome
#pacman -S gnome

# for xfce
#pacman -S xfce4 xfce4-goodies lxdm

# then install login manager and network manager. done.
# for gnome
# systemctl enable gdm
# systemctl enable NetworkManager

# for xfce
# systemctl enable lxdm
# systemctl enable NetworkManager
