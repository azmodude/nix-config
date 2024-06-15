# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  inputs,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.hardware.nixosModules.common-cpu-intel-kaby-lake
    inputs.hardware.nixosModules.common-pc-ssd
  ];

  boot = {
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    zfs.extraPools = ["rpool"];
    supportedFilesystems = {
        btrfs = true;
        zfs = true;
      };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
    initrd = {
      availableKernelModules = ["xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
      kernelModules = ["dm-snapshot"];
    };
  };
}
