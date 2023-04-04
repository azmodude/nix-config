{pkgs, ...}: {
  home.file.".config/zellij/themes/catppuccin.kdl" = {
    source =
      pkgs.fetchFromGitHub {
        owner = "zellij-org";
        repo = "zellij";
        rev = "9d4e60e";
        sha256 = "sha256-sShp4bZhvBN/EhfVuKinktr5bwXlWlUhj++vgGeHTfg=";
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
