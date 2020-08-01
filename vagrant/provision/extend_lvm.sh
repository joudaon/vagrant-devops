#!/bin/bash

## When using `vagrant-disksize` disk is resized it is not visible while using `df -h`.
## This scripts extends `LVM` partition.

# Create partition in /sda
echo "--> Creating partition in /sda"
(
echo n  # Add a new partition
echo p  # Primary partition
echo    # Partition number
echo    # First sector (Accept default: 1)
echo    # Last sector (Accept default: varies)
echo t  # Change partition type
echo    # partition number
echo 8e # partition type Linux LVM
echo p  # display validate partition
echo w  # Write changes
) | fdisk /dev/sda

echo "--> Displaying fdisk"
fdisk -l /dev/sda
echo "--> Displaying partitions"
ls -l /dev/sd*
echo "--> Displaying pyshical volume"
pvdisplay
echo "--> Creating pyshical volume"
pvcreate /dev/sda2
echo "--> Displaying pyshical volume"
pvdisplay
echo "--> Displaying volume groups"
vgdisplay
echo "--> Extending volume group"
vgextend -v vagrant-vg /dev/sda2
echo "--> Displaying volume groups"
vgdisplay
echo "--> Extending logical volume"
lvextend -r -l +100%FREE /dev/vagrant-vg/root
echo "--> Displaying df -h"
df -h

