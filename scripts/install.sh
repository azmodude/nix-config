#!/usr/bin/env bash

HAS_DISKO=0
TARGET_HOST=""
TARGET_USER=""

if [ "${1}" != "" ]; then
	TARGET_HOST="${1}"
else
	echo "ERROR! $(basename "${0}") requires a host name:"
	ls -1 hosts/ | grep -v ".nix" | grep -v common
	exit 1
fi

case "$TARGET_HOST" in
apollo | artemis | hephaestus | work-vm) true ;;
*)
	echo "ERROR! ${TARGET_HOST} is not a supported host"
	exit 1
	;;
esac

if [ "${2}" != "" ]; then
	TARGET_USER="${2}"
else
	echo "ERROR! $(basename "${0}") requires a user name"
	ls -1 hosts/common/users | grep -v ".nix" | grep -v root
	exit 1
fi

case "$TARGET_USER" in
azmo | j525980) true ;;
*)
	echo "ERROR! ${TARGET_USER} is not a supported user"
	exit 1
	;;
esac

if [ ! -e "hosts/${TARGET_HOST}/disks.nix" ]; then
	echo "WARNING! $(basename "${0}") could not find the required hosts/${TARGET_HOST}/disks.nix"
	echo "Will skip disk partitioning!"
else
	HAS_DISKO=1
fi

if [ "$(id -u)" -eq 0 ]; then
	echo "ERROR! $(basename "${0}") should be run as a regular user"
	exit 1
fi

echo "WARNING! The disks in ${TARGET_HOST} are about to get wiped"
echo "         NixOS will be re-installed"
echo "         This is a destructive operation"
echo
read -p "Are you sure? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	sudo true

	[[ ${HAS_DISKO} -eq 1 ]] && sudo nix run github:nix-community/disko --extra-experimental-features 'nix-command flakes' --no-write-lock-file -- --mode zap_create_mount "hosts/${TARGET_HOST}/disks.nix"
	# create empty snapshot of btrfs-root until disko supports it
	findmnt -o FSTYPE /mnt | grep -q btrfs && sudo mkdir -p /mnt/.snapshots/system && sudo btrfs subvolume snapshot /mnt/ /mnt/.snapshots/system/@.blank

	if [[ ! -e "/mnt/persist/etc/ssh/ssh_host_ed25519_key" ]]; then
		sudo mkdir -p "/mnt/persist/etc/ssh"
		echo "ERROR! No ssh_host_ed25519_key found in /mnt/persist/etc/ssh."
		echo "Please copy the proper host key to /mnt/persist/etc/ssh/ssh_host_ed25519_key for sops-nix to work its magic."
		read -p "Did you copy the key? [y/N] " -n 1 -r
		if [[ ! -e "/mnt/persist/etc/ssh/ssh_host_ed25519_key" ]]; then
			echo "ERROR! Ensure sops-nix/SSH Key configuration for host is correct."
			exit 1
		fi
	fi
	if [[ ! -e "/mnt/persist/etc/ssh/ssh_host_rsa_key" ]]; then
		sudo mkdir -p "/mnt/persist/etc/ssh"
		echo "ERROR! No ssh_host_rsa_key found in /mnt/persist/etc/ssh."
		echo "Please copy the proper host key to /mnt/persist/etc/ssh/ssh_host_rsa_key to ensure proper functionality."
		read -p "Did you copy the key? [y/N] " -n 1 -r
		if [[ ! -e "/mnt/persist/etc/ssh/ssh_host_rsa_key" ]]; then
			echo "ERROR! Ensure SSH Key configuration for host is correct."
			exit 1
		fi
	fi

	sudo nixos-install --no-root-password --flake ".#${TARGET_HOST}"

	# Rsync my nix-config to the target install
	sudo mkdir -p "/mnt/home/${TARGET_USER}/nix-config"
	sudo rsync -a --delete "${PWD}/" "/mnt/home/${TARGET_USER}/nix-config/"
	sudo chown -R "${TARGET_USER}:${TARGET_USER}" "/mnt/home/${TARGET_USER}"
fi
