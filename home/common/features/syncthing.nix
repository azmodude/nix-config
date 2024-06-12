{
  config,
  pkgs,
  user,
  ...
}: {
  # make syncthing related links for workstations
  systemd.user.tmpfiles.rules = [
    "L+ /persist/home/${user.name}/Documents/sync - - - - /persist/home/${user.name}/sync/workstations-documents"
    "L+ /persist/home/${user.name}/Pictures/sync - - - - /persist/home/${user.name}/sync/workstations-pictures"
    "L+ /persist/home/${user.name}/projects/sync - - - - /persist/home/${user.name}/sync/workstations-projects"
  ];
}
