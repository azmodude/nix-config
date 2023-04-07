{
  pkgs,
  lib,
  config,
  ...
}:
# we don't want GDM to suspend artemis - it's sometimes running headless
let
  autosuspend = {artemis = false;};
in {
  services = {
    xserver = {
      enable = true;
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        wayland = true;
        enable = true;
        autoSuspend =
          if (builtins.hasAttr config.networking.hostName autosuspend)
          then (builtins.getAttr config.networking.hostName autosuspend)
          else true;
      };
    };
    geoclue2.enable = true;
    gnome.games.enable = false;
  };
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.gnome-sound-recorder
    pantheon.elementary-wallpapers
  ];

  # enable gsconnect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

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
