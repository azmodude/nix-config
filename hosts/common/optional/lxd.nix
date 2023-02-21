{
  virtualisation.lxd = {
    enable = true;
    recommendedSysctlSettings = true;
  };
  environment.persistence = {
    "/persist".directories = [
      {
        directory = "/var/lib/lxd";
        user = "root";
        group = "root";
        mode = "u=rwx,g=,o=";
      }
    ];
  };
}
