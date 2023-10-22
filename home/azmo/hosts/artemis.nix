{
  inputs,
  pkgs,
  pkgs-stable,
  user,
  desktop,
  lib,
  ...
}: {
  imports =
    [
      ../../common/global
      ../../common/features/cli
      ../../common/features/development
      ../../common/features/nvim
      ../../common/features/sops.nix
      ../../common/features/syncthing.nix
      ../../common/features/desktop/common/libreoffice.nix
    ]
    ++ lib.optional (builtins.isString desktop.environment) ../../common/features/desktop/common
    ++ lib.optional (builtins.isString desktop.environment) ../../common/features/desktop/${desktop.environment};

  systemd.user.services = {
    backup-wow = {
      Unit = {
        Description = "rsync wow Interface and WTF to a place restic will pick it up";
        RequiresMountFor = "/home";
      };
      Service = {
        Type = "oneshot";
        ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/Games/WoW";
        ExecStart = pkgs.writeShellScript "backup-wow.sh" ''
          ${pkgs.rsync}/bin/rsync -av "$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles/WoW/drive_c/Program Files (x86)/World of Warcraft/_retail_/Interface" "$HOME/Games/WoW"
          ${pkgs.rsync}/bin/rsync -av "$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles/WoW/drive_c/Program Files (x86)/World of Warcraft/_retail_/WTF" "$HOME/Games/WoW"
        '';
      };
      Install = {
        WantedBy = ["multi-user.target"];
      };
    };
  };
  systemd.user.timers = {
    backup-wow = {
      Unit = {
        Description = "rsync wow Interface and WTF to a place restic will pick it up once per hour";
      };
      Timer = {
        Unit = "backup-wow";
        OnBootSec = "30m";
        OnCalendar = "hourly";
      };
      Install = {
        WantedBy = ["timers.target"];
      };
    };
  };
}
