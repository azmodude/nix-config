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
in {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        terminal = "${pkgs.kitty}/bin/kitty";
        bars = [
          {
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs config-bottom.toml";
          }
        ];
      };
      extraConfig = ''
        ${catppuccin-macchiato-i3}
      '';
    };
  };
  programs.i3status-rust = {
    enable = true;
    bars = {
      bottom = {
        icons = "awesome6";
        blocks = [
          {
            block = "cpu";
          }
          {
            block = "load";
            format = " $icon $1m ";
          }
          {
            block = "memory";
            format = " $icon $mem_total_used_percents.eng(w:2) ";
            format_alt = " $icon_swap $swap_used_percents.eng(w:2) ";
          }
        ];
      };
    };
  };
}
