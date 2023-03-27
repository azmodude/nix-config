{config, ...}: {
  services.restic.backups = {
    home = {
      initialize = true;
      repository = "rest:https://n9hn9osp:BhSCAZTq4D8H8rWI@n9hn9osp.repo.borgbase.com";
      passwordFile = config.sops.secrets.restic-workstations.path;
      paths = ["/home"];
      exclude = [
        "/home/*/Downloads"
        "/home/*/Games"
        "/home/*/.cache"
        "/home/*/.local/state"
        "/home/*/.local/share/bottles"
        "/home/*/.local/share/flatpak"
        "/home/*/.local/share/lutris"
        "/home/*/.local/share/Trash"
        "/home/*/.local/share/Steam"
        "/home/*/.var"
        "*.qcow2"
        "*.iso"
      ];
      extraBackupArgs = [
        "--exclude-if-present=.nobackup"
      ];

      timerConfig = {
        OnCalendar = "daily";
        RandomizedDelaySec = "1h";
      };
    };
  };
  sops.secrets.restic-workstations = {
    sopsFile = ../secrets.yaml;
  };
}
