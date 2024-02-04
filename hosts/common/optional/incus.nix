{
  virtualisation.incus = {
    enable = true;
    socketActivation = true;
    preseed = {
      config = {};
      networks = [
        {
          config = {
            "ipv4.address" = "auto";
            "ipv6.address" = "auto";
          };
          description = "Default network";
          name = "incusbr0";
          type = "";
          project = "default";
        }
      ];
      storage_pools = [
        {
          config = {
            source = "/var/lib/incus/storage-pools/default";
          };
          description = "Default storage pool";
          name = "default";
          driver = "btrfs";
        }
      ];
      profiles = [
        {
          config = {};
          description = "Default profile";
          devices = {
            eth0 = {
              name = "eth0";
              network = "incusbr0";
              type = "nic";
            };
            root = {
              path = "/";
              pool = "default";
              type = "disk";
            };
          };
          name = "default";
        }
      ];
      projects = [];
      cluster = null;
    };
  };
  # Trust incus bridging interface
  networking.firewall.trustedInterfaces = ["incusbr0"];

  environment.persistence = {
    "/persist".directories = [
      {
        directory = "/var/lib/incus";
        user = "root";
        group = "root";
        mode = "u=rwx,g=,o=";
      }
    ];
  };
}
