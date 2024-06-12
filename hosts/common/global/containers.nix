{
  lib,
  pkgs,
  ...
}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings = {
      dns_enabled = true;
    };
  };
  # add dnsname plugin for cni
  virtualisation.containers.containersConf.cniPlugins = with pkgs; [cni-plugins dnsname-cni];
  environment.systemPackages = with pkgs; [distrobox docker-compose podman-compose exfat];

  environment.persistence = {
    "/persist" = {
      directories = [
      "/var/lib/containers"
    ];
    hideMounts = true;
    };
  };
}
