{ config, ... }:
{
  # make syncthing related links for workstations
  systemd.user.tmpfiles.rules = [
    "L+ ${config.home.homeDirectory}/Documents/synced - - - - ${config.home.homeDirectory}/sync/workstations/documents"
  ];

  home.persistence."/persist/home/azmo" = {
    directories = ["sync"];
  };
}
