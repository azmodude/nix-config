{
  pkgs,
  user,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland.override {
      cfg = {
        enableTridactylNative = true;
        mesa = true;
        pipewire = true;
        ffmpeg_5 = true;
        plasma5Packages = true;
        cups = true;
      };
    };
    profiles = {
      "azmo-default" = {
        id = 0;
        isDefault = true;
        # make sure we are using ffmpeg for video acceleration
        settings = {
          "media.ffmpeg.vaapi.enabled" = true;
        };
      };
      "azmo-work" = {
        id = 1;
        isDefault = false;
        # make sure we are using ffmpeg for video acceleration
        settings = {
          "media.ffmpeg.vaapi.enabled" = true;
        };
      };
    };
  };
  home = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      BROWSER = "firefox";
    };
    persistence = {
      "/persist/home/${user}".directories = [".mozilla/firefox"];
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}
