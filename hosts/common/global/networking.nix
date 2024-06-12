{
  config,
  hostname,
  hostid,
  domain,
  lib,
  ...
}: {
  # Use passed in hostid and hostname to configure basic networking
  networking = {
    hostName = hostname;
     hostId = builtins.substring 0 8 (
      builtins.hashString "sha256" config.networking.hostName
    );
    domain = domain;
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = true;
      allowedTCPPorts = [8010]; # vlc chromecast support
    };
    nftables = {
      enable = true;
    };
  };
}
