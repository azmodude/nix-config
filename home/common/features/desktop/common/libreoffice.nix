{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice-fresh
    hyphen
    hunspell
    hunspellDicts.en-us-large
    hunspellDicts.en-gb-large
    hunspellDicts.de-de
  ];
}
