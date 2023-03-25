{
  pkgs,
  config,
  lib,
  outputs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.groups = {
    azmo = {
      gid = 1000;
    };
  };

  users.users.azmo = {
    uid = 1000;
    group = "azmo";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
        "users"
      ]
      ++ ifTheyExist [
        "network"
        "networkmanager"
        "wireshark"
        "i2c"
        "mysql"
        "docker"
        "lxd"
        "podman"
        "git"
        "libvirtd"
        "syncthing"
      ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMUkEk7GV/qWMR9SJFYSJSxwnPxR8fG2Fn9VILHcyPYQ"
    ];
    # TODO: is it possible to have a variable that chooses secrets based on hostname?
    passwordFile = config.sops.secrets.azmo-password.path;
    packages = [pkgs.home-manager];
  };

  sops.secrets.azmo-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  # ensure persist home exists and is secure
  systemd.tmpfiles.rules = [
    "d /persist/home/azmo 0700 azmo azmo - -"
    "z /persist/home/azmo 0700 azmo azmo - -"
  ];

  # this triggers a home-manager run on nixos-rebuild - which ATM causes problems with our extraSpecialArgs passed to hm since
  # they do not get passed along
  #home-manager.users.azmo = import home/${config.networking.hostName}.nix;
}
