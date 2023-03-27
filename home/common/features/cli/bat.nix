{pkgs, ...}: {
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      prettybat
      batwatch
      batpipe
      batman
      batgrep
      batdiff
    ];
    config = {
      theme = "catppuccin-macchiato";
    };
    themes = {
      catppuccin-macchiato = builtins.readFile (pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d168";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        }
        + "/Catppuccin-macchiato.tmTheme");
    };
  };
}
