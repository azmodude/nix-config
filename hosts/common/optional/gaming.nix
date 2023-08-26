{pkgs, ...}: {
  # sunshine
  environment.systemPackages = [pkgs.sunshine];
  # some kernel magic required
  boot.kernelModules = ["uinput"];
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';
  # configure avahi for discovery
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      userServices = true;
      hinfo = true;
      enable = true;
    };
  };

  # open network ports
  networking.firewall = {
    allowedTCPPorts = [47984 47989 48010];
    allowedUDPPortRanges = [
      {
        from = 47998;
        to = 48000;
      }
    ];
    allowedUDPPorts = [48002 48010];
  };
  # create security wrapper as sunshine needs cap_sys_admin
  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${pkgs.sunshine}/bin/sunshine";
  };
}
