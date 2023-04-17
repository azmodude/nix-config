{
  config,
  user,
  ...
}: {
  # make syncthing related links for workstations
  systemd.user.tmpfiles.rules = [
    "L+ /persist/home/${user}/Documents/synced - - - - /persist/home/${user}/sync/workstations/documents"
    "L+ /persist/home/${user}/Pictures/synced - - - - /persist/home/${user}/sync/workstations/pictures"
    "L+ /persist/home/${user}/projects/synced - - - - /persist/home/${user}/sync/workstations/projects"
  ];
}
