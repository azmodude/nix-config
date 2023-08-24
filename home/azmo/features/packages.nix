{pkgs, ...}: {
  home.packages = with pkgs; [
    bcompare
    google-chrome
    (vivaldi.override {proprietaryCodecs = true;})
  ];
}
