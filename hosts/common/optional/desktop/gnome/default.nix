{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        wayland = true;
        enable = true;
        autoSuspend = true;
      };
    };
    geoclue2.enable = true;
    gnome.games.enable = false;
  };
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    pantheon.elementary-wallpapers
  ];

  programs.dconf.enable = true;
  services.avahi = {
    enable = true;
    nssmdns = true;
  };
  services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
    ];
    xdgOpenUsePortal = true;
  };
}
