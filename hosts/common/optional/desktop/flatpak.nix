{pkgs, ...}: {
  services.flatpak = {
    enable = true;
  };
  systemd = {
    services = {
      flatpak-update = {
        unitConfig = {
          Description = "Flatpak Automatic Update";
          Documentation = "man:flatpak(1)";
          Wants = "network-online.target";
          After = "network-online.target";
        };
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.flatpak}/bin/flatpak --system update -y --noninteractive";
        };
        wantedBy = ["multi-user.target"];
      };
    };
    timers = {
      flatpak-update = {
        unitConfig = {
          Description = "Flatpak Automatic Update Timer";
          Documentation = "man:flatpak(1)";
        };
        timerConfig = {
          OnBootSec = "5m";
          OnCalendar = "0/6:00:00";
          Persistent = true;
        };
        wantedBy = ["timers.target"];
      };
    };
  };
}
