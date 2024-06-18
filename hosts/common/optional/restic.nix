{config, ...}: {
  services.restic.backups = {
    home = {
      initialize = true;
      repositoryFile = config.sops.secrets."restic/repository_url".path;
      passwordFile = config.sops.secrets."restic/repository_password".path;
      paths = ["/home"];
      exclude = [
        "/home/*/Downloads"
        "/home/*/Games/*"
        # only WoW Interface and WTF, game lives in $HOME/.var/app/com.usebottles.bottles/...
        "!/home/*/Games/WoW"
        "/home/*/.cache"
        "/home/*/.local/state"
        "/home/*/.local/share/containers"
        "/home/*/.local/share/bottles"
        "/home/*/.local/share/flatpak"
        "/home/*/.local/share/lutris"
        "/home/*/.local/share/JetBrains"
        "/home/*/.local/share/Steam"
        "/home/*/.local/share/Trash"
        "/home/*/.var"
        "*.qcow2"
        "*.iso"
      ];
      pruneOpts = [
        "--keep-hourly=24"
        "--keep-daily=7"
        "--keep-weekly=12"
        "--keep-monthly=12"
      ];
      checkOpts = ["--with-cache"];
      extraBackupArgs = [
        "--verbose --exclude-if-present=.nobackup"
      ];

      # fire backup job every 3 hours, randomized by 30 minutes
      timerConfig = {
        OnCalendar = "00/1:30";
        RandomizedDelaySec = "30minutes";
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
