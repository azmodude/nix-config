{
  lib,
  config,
  ...
}: let
  hostname = config.networking.hostName;
  wipeScript = ''
    mkdir /tmp -p
    MNTPOINT=$(mktemp -d)
    (
      mount -t btrfs -o subvol=/ /dev/disk/by-label/btrfs-root "$MNTPOINT"
      trap 'umount "$MNTPOINT"' EXIT

      echo "Creating needed directories"
      mkdir -p "$MNTPOINT"/persist/var/{log,lib/{nixos,systemd}}
      if [ -e "$MNTPOINT/persist/dont-wipe" ]; then
        echo "Skipping wipe"
      else
        echo "Cleaning root subvolume"
        btrfs subvolume list -o "$MNTPOINT/system/@" | cut -f9 -d ' ' |
        while read -r subvolume; do
          btrfs subvolume delete "$MNTPOINT/$subvolume"
        done && btrfs subvolume delete "$MNTPOINT/system/@"

        echo "Restoring blank subvolume"
        btrfs subvolume snapshot "$MNTPOINT/system/@-blank" "$MNTPOINT/system/@"
      fi
    )
  '';
  phase1Systemd = config.boot.initrd.systemd.enable;
in {
   boot.initrd = {
    supportedFilesystems = ["btrfs"];
    postDeviceCommands = lib.mkIf (!phase1Systemd) (lib.mkBefore wipeScript);
    systemd.services.restore-root = lib.mkIf phase1Systemd {
      description = "Rollback btrfs rootfs";
      wantedBy = ["initrd.target"];
      requires = ["dev-disk-by\\x2dlabel-btrfs\\x2droot.device"];
      after = [
        "dev-disk-by\\x2dlabel-btrfs\\x2droot.device"
        "systemd-cryptsetup@crypt\\x2dsystem.service"
      ];
      before = ["sysroot.mount"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = wipeScript;
    };
  };

  fileSystems = {
    "/persist" = {
      device = "/dev/disk/by-label/btrfs-root";
      fsType = "btrfs";
      options = ["subvol=data/@persist" "compress=zstd"];
      # /persist needs to be mounted early so sops-nix can access the host_key for decryption
      neededForBoot = true;
    };
  };
}
