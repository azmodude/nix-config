{config, ...}: {
  services.restic.backups = {
    home = {
      initialize = true;
      repositoryFile = config.sops.secrets."restic/repository_url".path;
      passwordFile = config.sops.secrets."restic/repository_password".path;
      paths = ["/home"];
      exclude = [
        "/home/*/Downloads"
        "/home/*/Games"
        "/home/*/.cache"
        "/home/*/.local/state"
        "/home/*/.local/share/containers"
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
        "--verbose --exclude-if-present=.nobackup"
      ];

      timerConfig = {
        OnCalendar = "daily";
        RandomizedDelaySec = "1h";
      };
    };
  };
  sops.secrets."restic/repository_url" = {
    sopsFile = ../../${config.networking.hostName}/secrets.yaml;
  };
  sops.secrets."restic/repository_password" = {
    sopsFile = ../../${config.networking.hostName}/secrets.yaml;
  };
}
