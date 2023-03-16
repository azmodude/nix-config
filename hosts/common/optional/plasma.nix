{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      desktopManager.plasma5 = {
        enable = true;
      };
      displayManager.sddm = {
        enable = true;
        autoNumlock = true;
      };
    };
    geoclue2.enable = true;
  };
  programs.dconf.enable = true;
  services.avahi = {
    enable = true;
    nssmdns = true;
  }
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      libsForQt5.xdg-desktop-portal-kde
    ];
    xdgOpenUsePortal = true;
  };
}
