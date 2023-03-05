{ pkgs, lib, ... }:
#let
#  steam-with-pkgs = pkgs.steam.override {
#    extraPkgs = pkgs: with pkgs; [
#      xorg.libXcursor
#      xorg.libXi
#      xorg.libXinerama
#      xorg.libXScrnSaver
#      libpng
#      libpulseaudio
#      libvorbis
#      stdenv.cc.cc.lib
#      libkrb5
#      keyutils
#    ];
#  };
#in
{
  home.packages = with pkgs; [
    gamescope
    protontricks
  ];
  home.persistence = {
    "/persist/games/azmo" = {
      allowOther = true;
      directories = [
        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
      ];
    };
  };
}
