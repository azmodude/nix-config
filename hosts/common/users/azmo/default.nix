{config, ...}: {
  users.users.azmo.hashedPasswordFile = config.sops.secrets.azmo-password.path;
  sops.secrets.azmo-password = {
    sopsFile = ./secrets.yaml;
    neededForUsers = true;
  };
  environment.localBinInPath = true;
}
