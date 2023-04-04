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
      "workstations-obsidian" = {
        path = "/home/${user}/sync/workstations/obsidian";
        id = "workstations-obsidian";
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
      "workstations-calibre" = {
        path = "/home/${user}/sync/workstations/calibre";
        id = "workstations-calibre";
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
        id = "U6I6IVI-FI6ODZT-JVIEILA-YYICPPW-3FMV7GP-GRBLHX3-QWEUK54-S7BZNA4";
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
