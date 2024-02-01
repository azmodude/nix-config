{
  virtualisation.incus = {
    enable = true;
    socketActivation = true;
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
