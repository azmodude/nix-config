{
  imports = [./btrbk.nix ./btrfs-optin-persistence.nix];
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/btrfs-root";
      fsType = "btrfs";
      options = ["subvol=system/@" "compress=zstd"];
    };
    "/.btrfs-root" = {
      device = "/dev/disk/by-label/btrfs-root";
      fsType = "btrfs";
      options = ["subvolid=5" "compress=zstd"];
    };
    "/.snapshots" = {
      device = "/dev/disk/by-label/btrfs-root";
      fsType = "btrfs";
      options = ["subvol=system/@snapshots" "compress=zstd" "noatime"];
    };
    "/var/log" = {
      device = "/dev/disk/by-label/btrfs-root";
      fsType = "btrfs";
      options = ["subvol=system/@var-log" "compress=zstd" "noatime"];
    };
    "/nix" = {
      device = "/dev/disk/by-label/btrfs-root";
      fsType = "btrfs";
      options = ["subvol=system/@nix" "compress=zstd" "noatime"];
    };

    "/home" = {
      device = "/dev/disk/by-label/btrfs-root";
      fsType = "btrfs";
      options = ["subvol=data/@home" "compress=zstd"];
    };

    "/boot" = {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
    };
  };

  services.btrfs.autoScrub = {
    enable = true;
    # avoid scrubbing multiple times, just do the root
    fileSystems = ["/.btrfs-root"];
    interval = "monthly";
  };
}
