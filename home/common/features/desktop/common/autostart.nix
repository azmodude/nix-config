{
  config,
  desktop,
  pkgs,
  lib,
  ...
}: {
  # autostart solaar
  home.file."${config.xdg.configHome}/autostart/solaar.desktop" = lib.mkIf (desktop.logitech == true) {
    # TODO: mkOutOfStoreSymlink isn't great, but I could not find a better way without using .text and writing my own
    #source = config.lib.file.mkOutOfStoreSymlink "/run/current-system/sw/share/applications/solaar.desktop";
    text = ''
      [Desktop Entry]
      Name=Solaar
      Comment=Logitech Unifying Receiver peripherals manager
      Exec=${pkgs.solaar}/bin/solaar -w hide --restart-on-wake-up --battery-icons solaar
      StartupNotify=false
      Terminal=false
      Type=Application
      Keywords=logitech;unifying;receiver;mouse;keyboard;
      Categories=Utility;GTK;
    '';
  };
  # autostart 1password
  home.file."${config.xdg.configHome}/autostart/1password.desktop".text = builtins.readFile "${pkgs._1password-gui}/share/applications/1password.desktop";
  # autostart syncthingtray
  home.file."${config.xdg.configHome}/autostart/syncthingtray.desktop".text = builtins.readFile "${pkgs.syncthingtray}/share/applications/syncthingtray.desktop";
}
