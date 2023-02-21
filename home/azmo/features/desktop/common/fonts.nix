{pkgs, ...}: {
  fonts.fontconfig = {
    enable = true;
  };

  home.packages = with pkgs; [
    (pkgs.nerdfonts.override {fonts = ["Iosevka"];})
    inter
    victor-mono
  ];
}
