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
    # enable 1password integration
    extraConfig = ''
      IdentityAgent "~/.1password/agent.sock"
    '';
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

  # write SSH public keys
  home.file.".ssh/general.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMUkEk7GV/qWMR9SJFYSJSxwnPxR8fG2Fn9VILHcyPYQ";
  home.file.".ssh/git.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICQh4341SBJaXdFAvDtAvS9zs4tiS5v8jod0OhgzBXpV";
  home.file.".ssh/netcup.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGgxP6hdnBAK8gYgHBFwmtNvgQmFii0RUiSifZ3KgmlU";
  home.file.".ssh/upcloud.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ6nxegS8y2rC6ldf4mxG3iyuJilxvDLzCote2RSmViG";

  # ensure secure controlPath exists and secure ~/.ssh
  systemd.user.tmpfiles.rules = [
    "d /home/${user}/tmp/.ssh 0700 ${user} ${user} 10d -"
    "z /home/${user}/.ssh 0700 ${user} ${user} - -"
    "z /home/${user}/.ssh/*.pub 0600 ${user} ${user} - -"
  ];
  sops.secrets.ssh-config-personal = {
    sopsFile = ../../../${user}/secrets.yaml;
    path = ".ssh/config.d/ssh-config-personal";
  };

  home.persistence."/persist/home/${user}" = {
    directories = [".ssh"];
  };
}
