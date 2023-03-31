{
  pkgs,
  config,
  lib,
  outputs,
  user,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.groups.${user} = {
    gid = 1000;
  };

  users.users.${user} = {
    uid = 1000;
    group = user;
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
    packages = [pkgs.home-manager];
  };

  programs.zsh.enable = true;

  # ensure persist home exists and is secure
  systemd.tmpfiles.rules = [
    "d /persist/home/${user} 0700 ${user} ${user} - -"
    "z /persist/home/${user} 0700 ${user} ${user} - -"
  ];

  # this triggers a home-manager run on nixos-rebuild - which ATM causes problems with our extraSpecialArgs passed to hm since
  # they do not get passed along
  #home-manager.users.azmo = import home/${config.networking.hostName}.nix;
}
