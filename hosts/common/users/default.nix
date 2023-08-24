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
  users.groups.${user.name} = {
    gid = 1000;
  };

  users.users.${user.name} = {
    uid = 1000;
    description = "${user.fullName}";
    group = user.name;
    isNormalUser = true;
    createHome = true;
    homeMode = "0700";
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

    openssh.authorizedKeys.keys = user.sshKeys;
    packages = [pkgs.home-manager];
  };

  programs.zsh.enable = true;

  # ensure persist home exists and is secure
  systemd.tmpfiles.rules = [
    "d /persist/home/${user.name} 0700 ${user.name} ${user.name} - -"
    "z /persist/home/${user.name} 0700 ${user.name} ${user.name} - -"
  ];

  # this triggers a home-manager run on nixos-rebuild - which ATM causes problems with our extraSpecialArgs passed to hm since
  # they do not get passed along
  #home-manager.users.azmo = import home/${config.networking.hostName}.nix;
}
