{
  pkgs,
  lib,
  ...
}: {
  home.packages = [(pkgs.lutris.override {  extraPkgs = pkgs: [ pkgs.libnghttp2 pkgs.curl pkgs.winetricks ]; })];

  home.persistence = {
    "/persist/games/azmo" = {
      allowOther = true;
      directories = ["Games/Lutris" ".config/lutris" ".local/share/lutris"];
    };
  };
}
