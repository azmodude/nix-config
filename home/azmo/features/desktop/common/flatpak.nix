{pkgs, ...}: {
  systemd.user = {
    services = {
      flatpak-update = {
        Unit = {
          Description = "Flatpak Automatic Update";
          Documentation = "man:flatpak(1)";
          Wants = "network-online.target";
          After = "network-online.target";
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.flatpak}/bin/flatpak --user update -y --noninteractive";
        };
        Install = {
          WantedBy = ["multi-user.target"];
        };
      };
    };
    timers = {
      flatpak-update = {
        Unit = {
          Description = "Flatpak Automatic Update Timer";
          Documentation = "man:flatpak(1)";
        };
        Timer = {
          OnBootSec = "5m";
          OnCalendar = "0/6:00:00";
          Persistent = true;
        };
        Install = {
          WantedBy = ["timers.target"];
        };
      };
    };
  };
}
