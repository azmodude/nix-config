{config, user, ...}: {
  # make syncthing related links for workstations
  systemd.user.tmpfiles.rules = [
    "L+ /persist/home/${user}/Documents/synced - - - - /persist/home/${user}/sync/workstations/documents"
  ];
}
