{
  hostname,
  hostid,
  domain,
  lib,
  ...
}: {
  # Use passed in hostid and hostname to configure basic networking
  networking = {
    hostName = hostname;
    hostId = hostid;
    domain = domain;
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = true;
    };
  };
}
