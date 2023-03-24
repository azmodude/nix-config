{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
      dejavu_fonts
      inter
      iosevka-bin
      joypixels
      liberation_ttf
      noto-fonts
      roboto
      roboto-serif
      roboto-slab
      roboto-mono
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
      localConf = ''
        <!-- Replace Verdana with DejaVu Sans -->
        <match target="pattern">
          <test qual="any" name="family"><string>Verdana</string></test>
          <edit name="family" mode="assign" binding="same"><string>DejaVu Sans</string></edit>
        </match>
      '';
    };
  };

  # Accept the joypixels license
  nixpkgs.config.joypixels.acceptLicense = true;
}
