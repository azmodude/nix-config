{
  pkgs,
  config,
  ...
}: {
  home.file."${config.xdg.configHome}/zellij/themes/catppuccin.kdl" = {
    source =
      pkgs.fetchFromGitHub {
        owner = "zellij-org";
        repo = "zellij";
        rev = "d0a780d";
        sha256 = "sha256-Xj3On5xgMEB1ArL1OWigPxJjkYXT0xaFdFD7pAabh8k=";
      }
      + "/example/themes/catppuccin.kdl";
  };
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-macchiato";
    };
  };
}
