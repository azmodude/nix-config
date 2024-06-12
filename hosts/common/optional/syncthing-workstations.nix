{user, ...}: {
  services.syncthing = {
    settings = {
      gui = {
        address = "127.0.0.1:8384";
        # this is probably a bit insecure, but since we are exposing the API and stuff to only localhost
        # ... if someone has access to localhost, it's probably gameover anyway
        apiKey = "gzdwDH4s6Xd3Hst2uuMbG7rAVXcoPQnb";
      };
      folders = {
        "workstations-documents" = {
          path = "/home/${user.name}/sync/workstations-documents";
          id = "workstations-documents";
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "7776000"; # 90 days
            };
          };
          devices = ["artemis" "hephaestus" "apollo" "zeus"];
          ignorePerms = false;
        };
        "workstations-pictures" = {
          path = "/home/${user.name}/sync/workstations-pictures";
          id = "workstations-pictures";
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "7776000"; # 90 days
            };
          };
          devices = ["artemis" "hephaestus" "apollo" "zeus"];
          ignorePerms = false;
        };
        "workstations-projects" = {
          path = "/home/${user.name}/sync/workstations-projects";
          id = "workstations-projects";
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "7776000"; # 90 days
            };
          };
          devices = ["artemis" "hephaestus" "apollo" "zeus"];
          ignorePerms = false;
        };
        "workstations-calibre" = {
          path = "/home/${user.name}/sync/workstations-calibre";
          id = "workstations-calibre";
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "7776000"; # 90 days
            };
          };
          devices = ["artemis" "hephaestus" "apollo" "zeus"];
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
        zeus = {
          id = "7FNHSVF-LKIIARR-KUIZIAR-F6EGUVF-BIZONAO-XHRRZNV-3DNEDST-KHVYVAG";
        };
      };
    };
  };
  environment.persistence = {
    "/persist" = {
      directories = [
      {
        directory = "/home/${user.name}/sync";
        user = "${user.name}";
        group = "${user.name}";
        mode = "u=rwx,g=,o=";
      }
    ];
      hideMounts = true;
    };
  };
  # workaround a race condition that might happen if /home/${user.name}/sync already exists
  # impermanence does not change ownership if directory already exists
  systemd.tmpfiles.rules = [
    "d /persist/home/${user.name}/sync 0700 ${user.name} ${user.name} - - "
  ];
}
