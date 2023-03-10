# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{
  lib,
  pkgs,
  ...
}:
with lib.hm.gvariant; {
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/elementaryos-default";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/elementaryos-default";
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };

    "org/gnome/desktop/input-sources" = {
      remember-numlock-state = true;
      sources = [(mkTuple ["xkb" "de+nodeadkeys"]) (mkTuple ["xkb" "us"])];
      xkb-options = ["terminate:ctrl_alt_bksp" "caps:escape"];
    };

    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      document-font-name = "Sans 11";
      enable-hot-corners = false;
      font-antialiasing = "rgba";
      font-hinting = "slight";
      font-name = "Inter 10";
      gtk-theme = "Adwaita-dark";
      monospace-font-name = "Monospace 10";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      delay = mkUint32 250;
      repeat-interval = mkUint32 30;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = false;
      speed = 0.33;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      speed = 0.14529914529914523;
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      disable-microphone = false;
      old-files-age = mkUint32 30;
      recent-files-max-age = -1;
      remove-old-temp-files = true;
      remove-old-trash-files = true;
    };

    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/odin.jpg";
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 480;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Shift><Super>q" "<Alt>F4"];
      show-desktop = ["<Super>d"];
    };

    "org/gnome/desktop/wm/preferences" = {
      resize-with-right-button = true;
      titlebar-font = "Inter Medium 10";
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = mkUint32 3000;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "kitty";
      name = "Terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Shift><Super>f";
      command = "nautilus";
      name = "Files";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Shift><Control>space";
      command = "1password --quick-access";
      name = "1Password Quick Access";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      binding = "<Shift><Super>p";
      command = "1password --toggle";
      name = "1Password Toggle";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout = 3600;
      sleep-inactive-battery-timeout = 1800;
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = ["workspace-indicator@gnome-shell-extensions.gcampax.github.com" "appindicatorsupport@rgcjonas.gmail.com" "blur-my-shell@aunetx" "native-windows-placement@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" "espresso@coadmunkee.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "dash-to-dock@micxgx.gmail.com"];
      favorite-apps = ["firefox.desktop" "google-chrome.desktop" "kitty.desktop"];
      welcome-dialog-last-shown-version = "43.2";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = true;
      background-opacity = 0.8;
      custom-theme-shrink = true;
      dash-max-icon-size = 32;
      dock-fixed = false;
      dock-position = "LEFT";
      extend-height = false;
      height-fraction = 0.9;
      hide-delay = 0.10000000000000002;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      isolate-workspaces = true;
      multi-monitor = false;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "eDP-1";
    };

    "org/gnome/system/location" = {
      enabled = true;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };
  };
  home = {
    packages = with pkgs; [
      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash-to-dock
      gnomeExtensions.appindicator
      gnomeExtensions.workspace-indicator
      gnomeExtensions.espresso
    ];
    persistence = {
      "/persist/home/azmo".directories = [".local/share/keyrings"];
    };
  };
  # ensure keyrings are secured
  systemd.user.tmpfiles.rules = [
    "z /home/azmo/.local/share/keyrings 0700 azmo azmo - -"
  ];
}
