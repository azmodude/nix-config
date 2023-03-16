{pkgs, ...}: {
  services.printing = {
    enable = true;
    startWhenNeeded = true;
    drivers = [pkgs.hplipWithPlugin];
  };
  services.avahi = {
    enable = true;
    nssmdns = true;
  }
}
