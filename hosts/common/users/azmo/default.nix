{config, ...}: {
  users.users.azmo.passwordFile = config.sops.secrets.azmo-password.path;
  sops.secrets.azmo-password = {
    sopsFile = ./secrets.yaml;
    neededForUsers = true;
  };
}
