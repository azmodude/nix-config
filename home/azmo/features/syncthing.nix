{config, ...}: {
  # make syncthing related links for workstations
  systemd.user.tmpfiles.rules = [
    "L+ /persist/home/azmo/Documents/synced - - - - /persist/home/azmo/sync/workstations/documents"
  ];
}
