{pkgs, ...}: {
  home.file.".config/zellij/themes/catppuccin.yaml" = {
    source =
      pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "zellij";
        rev = "c378e28";
        sha256 = "iEFLJenbdzs37MBz+l84ihkTACXDuYEf+xaLGetNL44=";
      }
      + "/catppuccin.yaml";
  };
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-macchiato";
    };
  };
}
