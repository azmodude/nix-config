# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{
  lib,
  pkgs,
  ...
}:
with lib.hm.gvariant; {
  dconf.settings = {
    "org/gnome/system/location" = {
      enabled = true;
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-last-coordinates = mkTuple [52.113598560115186 7.6032];
      night-light-temperature = mkUint32 2700;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [(mkTuple ["xkb" "de+nodeadkeys"]) (mkTuple ["xkb" "us"])];
      xkb-options = ["terminate:ctrl_alt_bksp"];
    };
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
      "enable-hot-corners" = false;
      "gtk-theme" = "Adwaita-dark";
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/elementaryos-default";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/elementaryos-default";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/odin.jpg";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;

      # `gnome-extensions list` for a list
      enabled-extensions = [
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "dash-to-panel@jderose9.github.com"
        "native-windows-placement@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "espresso@coadmunkee.github.com"
      ];
      favorite-apps = ["firefox.desktop" "google-chrome.desktop" "org.wezfurlong.wezterm.desktop"];
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = true;
      background-opacity = 0.8;
      custom-theme-shrink = true;
      dash-max-icon-size = 32;
      dock-fixed = true;
      dock-position = "LEFT";
      extend-height = false;
      height-fraction = 0.9;
      isolate-workspaces = true;
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      animate-appicon-hover-animation-extent = "{'RIPPLE': 4, 'PLANK': 4, 'SIMPLE': 1}";
      appicon-margin = 6;
      appicon-padding = 4;
      available-monitors = [0];
      dot-style-focused = "CILIORA";
      dot-style-unfocused = "SQUARES";
      focus-highlight-dominant = true;
      hot-keys = true;
      hotkeys-overlay-combo = "TEMPORARILY";
      isolate-workspaces = true;
      leftbox-padding = -1;
      panel-anchors = ''
        {"0":"MIDDLE"}
      '';
      panel-element-positions = ''
        {"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}
      '';
      panel-lengths = ''
        {"0":100}
      '';
      panel-positions = ''
        {"0":"TOP"}
      '';
      panel-sizes = ''
        {"0":39}
      '';
      primary-monitor = 0;
      shortcut-previews = true;
      status-icon-padding = -1;
      trans-panel-opacity = 0.4;
      trans-use-custom-opacity = true;
      trans-use-dynamic-opacity = true;
      tray-padding = -1;
      window-preview-title-position = "TOP";
    };
  };

  home.packages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-panel
    gnomeExtensions.appindicator
    gnomeExtensions.workspace-indicator
    gnomeExtensions.espresso
  ];
}
