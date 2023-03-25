{ user, ... }:
{
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
            devices = [ "artemis" "hephaestus" ];
            ignorePerms = false;
            };
        };
      devices = {
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
      "/home/${user}/sync"
    ];
  };
}
