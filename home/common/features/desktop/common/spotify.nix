{
  config,
  hostname,
  pkgs,
  user,
  ...
}: let
  spotity-tui-catpuccin-macchiato =
    builtins.readFile
    (pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "spotify-tui";
        rev = "45a4ef1";
        sha256 = "sha256-RXJ+skwUu2miCbBDLXx0Md0aVgo3iub2rQBzICwYLMU=";
      }
      + "/macchiato.yml");
in {
  home.packages = with pkgs; [spotify-tui];
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username = "gordon@gordonschulz.de";
        password_cmd = "${pkgs.coreutils}/bin/cat /run/user/${toString user.uid}/secrets/spotify-password";

        device_name = "spotifyd-${hostname}";
        device_type = "computer";

        use_mpris = true;
        backend = "pulseaudio";
        bitrate = 320;
        volume_normalization = true;
      };
    };
  };
  # home.file."${config.xdg.configHome}/spotify-tui/config.yml" = {
  #     text =
  #   ''
  #   ${spotity-tui-catpuccin-macchiato}
  #   '';
  # };

  sops = {
    secrets.spotify-password = {
      sopsFile = ../../../secrets.yaml;
    };
  };
}
