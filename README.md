# nix-config

My personal nixos and home-manager configurations, heavily based on [misterio77's](https://github.com/misterio77) [nix-config](https://github.com/misterio77/nix-config) and [nix-starter-configs](https://github.com/misterio77/nix-starter-configs) repositories.

## scripts/btrfs_create_partitioning_scheme.sh
- wipes all filesystems and creates a ESP /boot partition as well as encrypted LVM for swap and root.
## scripts/flatpak.sh
- Install flatpaks until they can be declaratively managed by nix.
