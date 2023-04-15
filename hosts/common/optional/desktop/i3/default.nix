{pkgs, ...}: {
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  services.xserver = {
    enable = true;
    layout = "de";
    displayManager.lightdm.enable = true;
    # i3 is managed by home-manager via .xsession, therefore enable
    # a lightweight desktop manager so that lightdm doesn't complain
    desktopManager.xterm.enable = true;
  };
}
