{pkgs, ...}: {
  fonts.fontconfig = {
    enable = true;
  };

  home.packages = with pkgs; [
    # Add extra font packages here
  ];
}
