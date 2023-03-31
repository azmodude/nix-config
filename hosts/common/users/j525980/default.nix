{config, ...}: {
  users.users.j525980.passwordFile = config.sops.secrets.j525980-password.path;
  sops.secrets.j525980-password = {
    sopsFile = ./secrets.yaml;
    neededForUsers = true;
  };
}
