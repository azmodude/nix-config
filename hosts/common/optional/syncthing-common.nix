{
  config,
  user,
  hostname,
  ...
}: {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    systemService = true;
    user = user.name;
    cert = config.sops.secrets."syncthing/cert".path;
    key = config.sops.secrets."syncthing/key".path;
    settings = {
      gui = {
        user = "syncthing";
      };
      options = {
        urAccepted = 1;
      };
    };
  };
  sops.secrets."syncthing/cert" = {
    sopsFile = ../../${config.networking.hostName}/secrets.yaml;
    restartUnits = ["syncthing-init.service"];
  };
  sops.secrets."syncthing/key" = {
    sopsFile = ../../${config.networking.hostName}/secrets.yaml;
    restartUnits = ["syncthing-init.service"];
  };
}
