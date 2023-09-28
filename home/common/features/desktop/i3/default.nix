{
  pkgs,
  config,
  ...
}: let
  catppuccin-macchiato-i3 =
    ''
      # catppuccin-macchiato
    ''
    + (builtins.readFile (pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "i3";
        rev = "df1a972";
        sha256 = "sha256-9K5j2/dCZb6Z4jHLorRnNL8eQ2/m9NVbCY1+W3SYeKQ=";
      }
      + "/themes/catppuccin-macchiato"))
    + ''
      # catppuccin
      # target                 border    bg    text   indicator  childBorder
      client.focused           $pink     $base $text  $rosewater $pink
      client.focused_inactive  $mauve    $base $text  $rosewater $mauve
      client.unfocused         $mauve    $base $text  $rosewater $mauve
      client.urgent            $peach    $base $peach $overlay0  $peach
      client.placeholder       $overlay0 $base $text  $overlay0  $overlay0
      client.background        $base
    '';
  catppuccin-macchiato-polybar = builtins.readFile (pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "polybar";
      rev = "a9ea53b";
      sha256 = "sha256-WrN9lO9ElVK6fbv9Jf9vDZ5uNpXYRtGHdLTl8sPPtcY=";
    }
    + "/themes/macchiato.ini");
in {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        bars = [];
        gaps = {
          inner = 5;
          smartBorders = "on";
          smartGaps = true;
        };
        terminal = "${pkgs.wezterm}/bin/wezterm";
      };
      extraConfig = ''
        ${catppuccin-macchiato-i3}
      '';
    };
  };
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    settings = {
      "bar/top" = {
        width = "100%";
        height = "3%";
        background = "\${colors.base}";
        foreground = "\${colors.text}";
        radius = 0;
        font-0 = "Inter:size=9";
        font-1 = "Symbols Nerd Font:size=9";
        modules-left = "i3";
        modules-center = "title";
        modules-right = "cpu memory filesystem date";
      };
      "module/i3" = {
        type = "internal/i3";
      };
      "module/title" = {
        type = "internal/xwindow";
      };
      "module/cpu" = {
        type = "internal/cpu";
        label = "  %percentage%%";
        label-minlen = 8;
        interval = 5;
      };
      "module/memory" = {
        type = "internal/memory";
        label = "󰍛  %percentage_used%%";
        interval = 5;
        label-minlen = 10;
      };
      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";
        label-mounted = "  %mountpoint% %percentage_used%%";
        label-mounted-minlen = 15;
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%Y-%m-%d";
        time = "%H:%M";
        label = "%time%  %date%";
        format-foreground = "\${colors.rosewater}";
      };
    };
    extraConfig = ''
      ${catppuccin-macchiato-polybar}
    '';
    script = "polybar top &";
  };
}
