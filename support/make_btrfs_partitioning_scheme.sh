#!/usr/bin/env bash

DISK=/dev/disk/by-id/nvme-SAMSUNG_MZVLW512HMJP-000L7_S359NX0HC16935
SWAPSIZE=$(free -g | grep Mem: | awk '{print $2}') # swap size, defaults to available memory for hibernation
CRYPT_NAME="crypt-system"
LVM_NAME="lvm-crypt-system"

# clean disk and create partitions
sgdisk --zap-all ${DISK}
sgdisk -n1:1M:+1G -c1:"boot" -t1:EF00 ${DISK}
sgdisk -n2:0:0 -c2:"root" -t2:8300 ${DISK}

partprobe && sleep 3
for wipe in 1 2; do
  wipefs -a ${DISK}-part${wipe}
done

# create /boot
mkfs.vfat -n EFI ${DISK}-part1
# setup disk encryption
cryptsetup --verify-passphrase -v luksFormat --label crypt-system ${DISK}-part2
cryptsetup open ${DISK}-part2 ${CRYPT_NAME}

# setup lvm
pvcreate /dev/mapper/${CRYPT_NAME}
vgcreate ${LVM_NAME} /dev/mapper/${CRYPT_NAME}
lvcreate --size "${SWAPSIZE}G" --name swap ${LVM_NAME}
lvcreate --extents 100%FREE --name root ${LVM_NAME}

# create swap
mkswap /dev/${LVM_NAME}/swap
swapon /dev/${LVM_NAME}/swap

# setup btrfs and btrfs subvolumes
mkfs.btrfs -L btrfs-root /dev/${LVM_NAME}/root

mount -t btrfs /dev/${LVM_NAME}/root /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@nix
btrfs subvolume create /mnt/@persist
btrfs subvolume create /mnt/@persist/games
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@var-log

# We then take an empty *readonly* snapshot of the root subvolume,
# which we'll eventually rollback to on every boot (opt-in state)
btrfs subvolume snapshot -r /mnt/@ /mnt/@-blank
umount /mnt

# mount subvolumes into final destination
mount -o subvol=@,compress=zstd,noatime /dev/${LVM_NAME}/root /mnt
# mount root btrfs subvol-id for btrbk
mkdir -p /mnt/{.btrfs-root,home,nix,persist,.snapshots,var/log,boot}
mount -o subvolid=5,compress=zstd,noatime /dev/${LVM_NAME}/root /mnt/.btrfs-root
mount -o subvol=@home,compress=zstd,noatime /dev/${LVM_NAME}/root /mnt/home
mount -o subvol=@nix,compress=zstd,noatime /dev/${LVM_NAME}/root /mnt/nix
mount -o subvol=@persist,compress=zstd,noatime /dev/${LVM_NAME}/root /mnt/persist
mount -o subvol=@snapshots,compress=zstd,noatime /dev/${LVM_NAME}/root /mnt/.snapshots
mount -o subvol=@var-log,compress=zstd,noatime /dev/${LVM_NAME}/root /mnt/var/log

# mount /boot
mount ${DISK}-part1 /mnt/boot
