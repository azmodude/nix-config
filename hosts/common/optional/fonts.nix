{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
      inter
      iosevka-bin
      joypixels
      liberation_ttf
      source-sans
      source-serif
      source-code-pro
      victor-mono
    ];

    fontconfig = {
      antialias = true;
      defaultFonts = {
        serif = ["Source Serif 4" "Joypixels"];
        sansSerif = ["Source Sans 3" "Joypixels"];
        monospace = ["Source Code Pro" "JoyPixels"];
        emoji = ["Joypixels"];
      };
      hinting = {
        autohint = false;
        enable = true;
        style = "hintslight";
      };
      subpixel = {
        rgba = "rgb";
        lcdfilter = "light";
      };
    };
  };

  # Accept the joypixels license
  nixpkgs.config.joypixels.acceptLicense = true;
}
