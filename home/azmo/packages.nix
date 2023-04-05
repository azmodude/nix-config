{pkgs, ...}: {
  home.packages = with pkgs; [
    bcompare
    flameshot
    google-chrome
    thunderbird
    vivaldi
    vivaldi-ffmpeg-codecs
  ];
}
