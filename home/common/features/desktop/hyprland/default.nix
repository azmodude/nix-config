{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    mako
    swaybg
    swayidle
    swaylock
    wofi
  ];
  programs.waybar = {
    enable = true;
    systemd.enable = false;
  };
  home.file."${config.xdg.configHome}/waybar/style.css" = {
    source =
      pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "waybar";
        rev = "f74ab1e";
        sha256 = "sha256-WLJMA2X20E5PCPg0ZPtSop0bfmu+pLImP9t8A8V4QK8=";
      }
      + "/themes/macchiato.css";
  };
  services.kanshi = {
    enable = true;
  };
}
