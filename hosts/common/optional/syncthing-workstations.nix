{ user, ... }:
{
  services.syncthing = {
      folders = {
          "workstations-documents" = {
            path = "/home/${user}/sync/workstations/documents";
            id = "workstations-documents";
            };
        };
    };
}
