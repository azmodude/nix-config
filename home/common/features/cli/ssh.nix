{
  outputs,
  lib,
  user,
  ...
}: let
  hostnames = builtins.attrNames outputs.nixosConfigurations;
in {
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPersist = "30m";
    # we cannot use the default of ~/.ssh because that is bind-mounted and openSSH - rightfully so - does not like that
    controlPath = "~/tmp/.ssh/master-%r@%n:%p";
    includes = ["config.d/*"];
    matchBlocks = {
      net = {
        host = builtins.concatStringsSep " " hostnames;
        forwardAgent = true;
      };
      trusted = lib.hm.dag.entryBefore ["net"] {
        host = "m7.rs *.m7.rs *.ts.m7.rs";
        forwardAgent = true;
      };
    };
    serverAliveInterval = 15;
    hashKnownHosts = true;
  };

  # ensure secure controlPath exists and secure ~/.ssh
  systemd.user.tmpfiles.rules = [
    "d /home/${user.name}/tmp/.ssh 0700 ${user.name} ${user.name} 10d -"
    "z /home/${user.name}/.ssh 0700 ${user.name} ${user.name} - -"
    "z /home/${user.name}/.ssh/*.pub 0600 ${user.name} ${user.name} - -"
  ];
  sops.secrets.ssh-config-personal = {
    sopsFile = ../../../${user.name}/secrets.yaml;
    path = ".ssh/config.d/ssh-config-personal";
  };

  home.persistence."/persist/home/${user.name}" = {
    directories = [".ssh"];
  };
}
