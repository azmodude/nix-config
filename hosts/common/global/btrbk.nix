{
  services.btrbk = {
    instances = {
      btrbk.settings = {
        timestamp_format = "long";
        snapshot_preserve_min = "2d";
        snapshot_preserve = "7d";

        volume = {
          "/.btrfs-root" = {
            subvolume = {
              "@home" = {
                snapshot_create = "always";
                snapshot_dir = "@snapshots/home";
              };
            };
            subvolume = {
              "@persist" = {
                snapshot_create = "always";
                snapshot_dir = "@snapshots/persist";
              };
            };
          };
        };
        # run every 15 minutes
      };
      btrbk.onCalendar = "*:0/15";
    };
    ioSchedulingClass = "idle";
  };
  # ensure snapshots_dir exists
  systemd.tmpfiles.rules = [
    "d /.btrfs-root/@snapshots/home 0755 root root - -"
    "d /.btrfs-root/@snapshots/persist 0755 root root - -"
  ];
}
