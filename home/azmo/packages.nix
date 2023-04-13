{pkgs, ...}: {
  home.packages = with pkgs; [
    bcompare
    google-chrome
    thunderbird
    vivaldi
    vivaldi-ffmpeg-codecs
  ];
}
