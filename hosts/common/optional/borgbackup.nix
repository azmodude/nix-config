{
  services.borgbackup.jobs = {
    home = {
      paths = "/home/azmo/tmp";
      repo = "ssh://z2wy2u76@z2wy2u76.repo.borgbase.com/./repo";
      compression = "auto,zstd";
      extraCreateArgs = "--verbose --stats --checkpoint-interval 600";
      encryption = {
        mode = "repokey-blake2";
        passphrase = "ficken98";
      };
      environment.BORG_RSH = "ssh -o 'StrictHostKeyChecking=no' -i /home/azmo/borgbase-nopassword";
    };
  };
}
