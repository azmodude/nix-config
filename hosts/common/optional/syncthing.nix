{ config, user, ... }:
{
  services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      systemService = true;
      user = user;
      cert = config.sops.secrets."syncthing/cert".path;
      key = config.sops.secrets."syncthing/key".path;
      folders = {
          "workstations-documents" = {
            path = "/home/${user}/sync/workstations/documents";
            id = "workstations-documents";
            };
        };
    };
  sops.secrets."syncthing/cert" = {
    sopsFile = ../../${config.networking.hostName}/secrets.yaml;
    restartUnits = [ "syncthing-init.service" ];
  };
  sops.secrets."syncthing/key" = {
    sopsFile = ../../${config.networking.hostName}/secrets.yaml;
    restartUnits = [ "syncthing-init.service" ];
  };
}
