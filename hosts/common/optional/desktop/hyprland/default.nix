{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [polkit_gnome qt6.qtwayland libsForQt5.qt5.qtwayland gnome.gnome-keyring];
}
