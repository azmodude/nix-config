{pkgs, ...}: {
  home.file.".config/btop/themes/catppuccin_macchiato.theme" = {
    source =
      pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "btop";
        rev = "ecb8562";
        sha256 = "sha256-ovVtupO5jWUw6cwA3xEzRe1juUB8ykfarMRVTglx3mk=";
      }
      + "/catppuccin_macchiato.theme";
  };
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_macchiato";
    };
  };
}
