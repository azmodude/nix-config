{
  config,
  user,
  ...
}: {
  # make syncthing related links for workstations
  systemd.user.tmpfiles.rules = [
    "L+ /persist/home/${user.name}/Documents/synced - - - - /persist/home/${user.name}/sync/workstations/documents"
    "L+ /persist/home/${user.name}/Pictures/synced - - - - /persist/home/${user.name}/sync/workstations/pictures"
    "L+ /persist/home/${user.name}/projects/synced - - - - /persist/home/${user.name}/sync/workstations/projects"
  ];
}
