# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  desktop,
  domain,
  hostname,
  hostid,
  ...
}: {
  # You can import other NixOS modules here
  imports =
    [
      # If you want to use modules your own flake exports (from modules/nixos):
      # outputs.nixosModules.example

      # Or modules from other flakes (such as nixos-hardware):
      # inputs.hardware.nixosModules.common-cpu-amd
      # inputs.hardware.nixosModules.common-ssd

      # You can also split up your configuration and import pieces of it here:
      # ./users.nix

      # Import your generated (nixos-generate-config) hardware configuration
      ./hardware-configuration.nix

      ../common/optional/laptop.nix
      ../common/optional/encrypted-root.nix
      ../common/optional/restic.nix
      ../common/optional/btrfs
      ../common/optional/fwupd.nix
      ../common/optional/lxd.nix
      ../common/optional/libvirt.nix
      ../common/optional/desktop/logitech.nix
      ../common/optional/syncthing-common.nix
      ../common/optional/syncthing-workstations.nix
      # Only include desktop components if one is supplied.
      # - https://nixos.wiki/wiki/Nix_Language:_Tips_%26_Tricks#Coercing_a_relative_path_with_interpolated_variables_to_an_absolute_path_.28for_imports.29
    ]
    ++ lib.optional (builtins.isString desktop) ../common/optional/desktop
    ++ lib.optional (builtins.isString desktop) ../common/optional/desktop/${desktop};
}
