{
  outputs,
  lib,
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
  };

  # ensure secure controlPath exists
  systemd.user.tmpfiles.rules = [
    "d /home/azmo/tmp/.ssh 0700 azmo azmo 10d -"
  ];

  home.persistence."/persist/home/azmo" = {
    directories = [".ssh"];
    allowOther = false;
  };
}
