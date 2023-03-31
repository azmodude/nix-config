#!/usr/bin/env bash

TARGET_HOST=""
TARGET_USER=""

if [ -n "${1}" ]; then
  TARGET_HOST="${1}"
else
  echo "ERROR! $(basename "${0}") requires a host name:"
  ls -1 hosts/ | grep -v ".nix" | grep -v common
  exit 1
fi

case "${TARGET_HOST}" in
  hephaestus|artemis|work-vm) true;;
  *)
    echo "ERROR! ${TARGET_HOST} is not a supported host"
    exit 1
    ;;
esac

if [ -n "${2}" ]; then
  TARGET_USER="${2}"
else
  echo "ERROR! $(basename "${0}") requires a user name"
  ls -1 hosts/common/users | grep -v ".nix" | grep -v root
  exit 1
fi

case "${TARGET_USER}" in
  azmo|j525980) true;;
  *)
    echo "ERROR! ${TARGET_USER} is not a supported user"
    exit 1
    ;;
esac

if [ ! -e "hosts/${TARGET_HOST}/disks.nix" ]; then
  echo "ERROR! $(basename "${0}") could not find the required hosts/${TARGET_HOST}/disks.nix"
  exit 1
fi

if [ "$(id -u)" -eq 0 ]; then
  echo "ERROR! $(basename "${0}") should be run as a regular user"
  exit 1
fi

if [[ ! -e "/persist/etc/ssh/ssh_host_ed25519_key" ]]; then
  echo "ERROR! No ssh_host_ed25519_key found in /persist/etc/ssh."
  echo "ERROR! Ensure sops-nix configuration for host is correct."
fi

echo "WARNING! The disks in ${TARGET_HOST} are about to get wiped"
echo "         NixOS will be re-installed"
echo "         This is a destructive operation"
echo
read -p "Are you sure? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo true

    sudo nixos-install --no-root-password --flake ".#${TARGET_HOST}"

    # Rsync my nix-config to the target install
    mkdir -p "/mnt/home/${TARGET_USER}/nix-config"
    rsync -a --delete "${PWD}/" "/mnt/home/${TARGET_USER}/nix-config/"
fi
