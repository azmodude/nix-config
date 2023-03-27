{pkgs, ...}: {
  home.packages = with pkgs; [
    flameshot
    google-chrome
    thunderbird
    vivaldi
    vivaldi-ffmpeg-codecs
  ];
}
