{pkgs, ...}: {
  home.packages = with pkgs; [
    bcompare
    google-chrome
    thunderbird
    (vivaldi.override {proprietaryCodecs = true;})
  ];
}
