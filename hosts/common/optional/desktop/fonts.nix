{
  pkgs,
  lib,
  ...
}: let
  iosevka-variants = ["SS14" "Etoile" "Aile" "Curly" "CurlySlab" "Slab"];
  iosevka = lib.lists.forEach iosevka-variants (x: (pkgs.iosevka-bin.override {variant = "${x}";}));
in {
  fonts = {
    fontDir.enable = true;
    packages = with pkgs;
      [
        (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
        commit-mono
        dejavu_fonts
        jetbrains-mono
        inter
        liberation_ttf
        noto-fonts
        open-sans
        roboto
        roboto-serif
        roboto-slab
        roboto-mono
        source-sans
        source-serif
        source-code-pro
        victor-mono
      ]
      ++ iosevka;

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
        style = "slight";
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
