{pkgs, ...}: {
  services.printing = {
    enable = true;
    startWhenNeeded = true;
    drivers = with pkgs; [hplip cups-filters];
  };
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
}
