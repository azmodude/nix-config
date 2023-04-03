{user, ...}: {
  services.syncthing = {
    folders = {
      "workstations-documents" = {
        path = "/home/${user}/sync/workstations/documents";
        id = "workstations-documents";
        versioning = {
          type = "staggered";
          params = {
            cleanInterval = "3600";
            maxAge = "7776000"; # 90 days
          };
        };
        devices = ["artemis" "hephaestus" "apollo"];
        ignorePerms = false;
      };
      "workstations-projects" = {
        path = "/home/${user}/sync/workstations/projects";
        id = "workstations-projects";
        versioning = {
          type = "staggered";
          params = {
            cleanInterval = "3600";
            maxAge = "7776000"; # 90 days
          };
        };
        devices = ["artemis" "hephaestus" "apollo"];
        ignorePerms = false;
      };
    };
    devices = {
      apollo = {
        id = "5RKIJKF-JXHBALB-DJMLNSH-PNE653J-7QKC4YL-33KJCCF-ZPVECMD-A7RKWQG";
      };
      artemis = {
        id = "MAX6UIX-AMT37KO-6J73NWB-DLO6CR7-X3PCVQU-X4BIH5V-EJMVBKX-2VI2AQD";
      };
      hephaestus = {
        id = "DMZFY3M-OPJKLBJ-EFSIXWI-L3ALBEC-5FJJGHD-UEE7IOV-QTOEOFE-R6S7ZA7";
      };
    };
  };
  environment.persistence = {
    "/persist".directories = [
      {
        directory = "/home/${user}/sync";
        user = "${user}";
        group = "${user}";
        mode = "u=rwx,g=,o=";
      }
    ];
  };
  # workaround a race condition that might happen if /home/${user}/sync already exists
  # impermanence does not change ownership if directory already exists
  systemd.tmpfiles.rules = [
    "d /persist/home/${user}/sync 0700 azmo azmo - - "
  ];
}
