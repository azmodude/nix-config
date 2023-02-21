{
  lib,
  pkgs,
  ...
}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

  environment.persistence = {
    "/persist".directories = [
      "/var/lib/containers"
    ];
  };

  environment.systemPackages = [pkgs.distrobox];
}
