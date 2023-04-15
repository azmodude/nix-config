{
  imports = [./btrbk.nix ./btrfs-optin-persistence.nix];
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/btrfs-root";
      fsType = "btrfs";
      options = ["subvol=@" "compress=zstd"];
    };
    "/.btrfs-root" = {
      device = "/dev/disk/by-label/btrfs-root";
      fsType = "btrfs";
      options = ["subvolid=5" "compress=zstd"];
    };
    "/.snapshots" = {
      device = "/dev/disk/by-label/btrfs-root";
      fsType = "btrfs";
      options = ["subvol=@snapshots" "compress=zstd" "noatime"];
    };

    "/home" = {
      device = "/dev/disk/by-label/btrfs-root";
      fsType = "btrfs";
      options = ["subvol=@home" "compress=zstd"];
    };
    "/var/log" = {
      device = "/dev/disk/by-label/btrfs-root";
      fsType = "btrfs";
      options = ["subvol=@var-log" "compress=zstd" "noatime"];
    };

    "/nix" = {
      device = "/dev/disk/by-label/btrfs-root";
      fsType = "btrfs";
      options = ["subvol=@nix" "compress=zstd" "noatime"];
    };
    "/boot" = {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
    };
  };

  swapDevices = [
    {device = "/dev/lvm-crypt-system/swap";}
  ];

  services.btrfs.autoScrub = {
    enable = true;
    # avoid scrubbing multiple times, just do the root
    fileSystems = ["/.btrfs-root"];
    interval = "monthly";
  };
}
