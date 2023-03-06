{pkgs, ...}: {
  fonts.fontconfig = {
    enable = true;
  };

  home.packages = with pkgs; [
    (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    iosevka-bin
    inter
    victor-mono
  ];
}
