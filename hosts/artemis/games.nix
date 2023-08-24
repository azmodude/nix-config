{user, ...}: {
  fileSystems."/persist/games" = {
    device = "/dev/disk/by-label/btrfs-root";
    fsType = "btrfs";
    options = ["subvol=data/@persist/games" "compress=zstd"];
  };

  # ensure persist game directory exists and has correct permission
  systemd.tmpfiles.rules = [
    "d /persist/games 0755 ${user.name} ${user.name} - -"
    "z /persist/games 0755 ${user.name} ${user.name} - -"
  ];
}
