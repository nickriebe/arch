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
