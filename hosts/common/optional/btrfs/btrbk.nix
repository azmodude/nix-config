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
              "data/@home" = {
                snapshot_create = "always";
                snapshot_dir = "/.snapshots/data/@home";
              };
            };
            subvolume = {
              "data/@persist" = {
                snapshot_create = "always";
                snapshot_dir = "/.snapshots/data/@persist";
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
    "d /.snapshots/data/@home 0755 root root - -"
    "d /.snapshots/data/@persist 0755 root root - -"
  ];
}
